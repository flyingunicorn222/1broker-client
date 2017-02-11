call      = require '../call'
calculate = require '../../helpers/calculate'

module.exports = ( config, params, callback ) ->

  stop_loss   = params.stop_loss            || ""
  take_profit = params.take_profit          || ""
  price       = params.order_type_parameter || ""

  params.leverage = params.leverage || 1
  params.margin   = params.margin   || 0.01

  params.symbol = params.symbol.toUpperCase()

  if tp_is_percentage = take_profit.indexOf( "%" ) isnt -1
    take_profit = Number take_profit.replace( "%", "" )
    take_profit = "#{take_profit}%"
  else if tp_is_points = ( take_profit[0] is '-' or take_profit[0] is '+' )
    take_profit = Number take_profit
    take_profit = "+#{take_profit}"

  if sl_is_percentage = stop_loss.indexOf("%") isnt -1
    stop_loss = Number stop_loss.replace( "%", "" )
    stop_loss = "-#{stop_loss}%"
  else if sl_is_points = ( stop_loss[0] is '-' or stop_loss[0] is '+' )
    stop_loss = Number stop_loss
    stop_loss = "-#{stop_loss}"

  if not stop_loss
    delete params.stop_loss

  if not take_profit
    delete params.take_profit

  needs_quote = tp_is_percentage or tp_is_points
  needs_quote = needs_quote or sl_is_percentage or sl_is_points

  # if not using or using absolute values for SL / TP
  if not needs_quote

    return call config, 'order/create', params, callback

  execute = ( price ) ->

    calculated = calculate params.symbol, params.leverage, price, params.direction, params.stop_loss, params.take_profit

    params.take_profit = calculated.take_profit
    params.stop_loss   = calculated.stop_loss

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
