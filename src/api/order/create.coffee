call    = require '../call'
details = require '../../info/details'

add_percentage = require '../../helpers/add/percentage'
add_points     = require '../../helpers/add/points'

# TODO: replace % calculation for the new add.percentage method
# TODO: add support to +/- points as well, not only percentage

module.exports = ( config, params, callback ) ->

  stop_loss   = params.stop_loss            || ""
  take_profit = params.take_profit          || ""
  price       = params.order_type_parameter || ""

  params.leverage = params.leverage || 1
  params.margin   = params.margin   || 0.01

  params.symbol = params.symbol.toUpperCase()

  needs_quote = false

  ## if it's percentage we will need quote
  needs_quote = needs_quote or stop_loss.indexOf( "%" ) isnt -1
  needs_quote = needs_quote or take_profit.indexOf( "%" ) isnt -1

  ## if it's points we will need quote
  needs_quote = needs_quote or (   stop_loss[0] is '-' or   stop_loss[0] is '+' )
  needs_quote = needs_quote or ( take_profit[0] is '-' or take_profit[0] is '+' )

  ## check for strings on leverage field, this way we can convert
  ## MAX / HALF / QUARTER to actual numbers
  if typeof params.leverage is 'string'

    params.leverage = params.leverage.toUpperCase()

    if [ 'MAX', 'HALF', 'QUARTER' ].indexOf( params.leverage ) isnt -1

      max = details[ params.symbol ].maximum_leverage

      if params.leverage is 'MAX'
        params.leverage = max

      if params.leverage is 'HALF'
        params.leverage = Math.ceil max / 2

      if params.leverage is 'QUARTER'
        params.leverage = Math.ceil max / 4

  if not stop_loss
    delete params.stop_loss

  if not take_profit
    delete params.take_profit

  # if not using or using absolute values for SL / TP
  if not needs_quote

    console.log "doesnt need quote, directly call!"

    return call config, 'order/create', params, callback

  ## NOTE: set and check variable at the same time here!
  if tp_is_percentage = take_profit.indexOf( "%" ) isnt -1
    take_profit = Number take_profit.replace( "%", "" )

  else if tp_is_points = ( take_profit[0] is '-' or take_profit[0] is '+' )
    take_profit = Number take_profit
  ##
  #NOTE: set and check variable at the same time here!
  if sl_is_percentage = stop_loss.indexOf("%") isnt -1
    stop_loss = Number stop_loss.replace( "%", "" )
  else if sl_is_points = ( stop_loss[0] is '-' or stop_loss[0] is '+' )
    stop_loss = Number stop_loss

  ## always read % as positive, since when opening the order it will
  ## always be negative and we need to normalize

  if take_profit then take_profit = Math.abs take_profit
  if stop_loss   then stop_loss   = Math.abs stop_loss

  if params.direction is 'short'
    take_profit = -take_profit

  if params.direction is 'long'
    stop_loss   = -stop_loss

  execute = ( price ) ->
    if tp_is_percentage
      take_profit = add_percentage( price, params.leverage, take_profit )

    if sl_is_percentage
      stop_loss   = add_percentage( price, params.leverage, stop_loss )

    if tp_is_points
      take_profit = add_points( params.symbol, price, take_profit )

    if sl_is_points
      stop_loss   = add_points( params.symbol, price, stop_loss )

    if take_profit then params.take_profit = take_profit
    if stop_loss   then params.stop_loss   = stop_loss

    console.log '1broker client params ->', params

    return

    return call config, 'order/create', params, callback

  if params.order_type is 'limit'

    ## if its a limit order we already know all the values
    ## put the order, it's the end of our work!
    return execute price

  if params.order_type is 'market'

    call config, 'market/quotes', { symbols: params.symbol }, ( error, result ) ->

      if error then return callback?( error )

      if params.direction is 'short'
        price = result.response[0].bid

      if params.direction is 'long'
        price = result.response[0].ask

      return execute price
