details = require '../info/details'

add_percentage = require './add/percentage'
add_points     = require './add/points'

# receives order parameters and calculate params accordingly
module.exports = ( symbol, leverage, price, direction, stop_loss, take_profit ) ->

  symbol    = symbol.toUpperCase()
  direction = direction.toLowerCase()

  info         = details[ symbol ]
  max_leverage = info.maximum_leverage

  stop_loss   = stop_loss   || ""
  take_profit = take_profit || ""

  params = {}

  if typeof leverage is 'number'

    if leverage > max_leverage
      console.warn "Leverage #{leverage} is too high for #{symbol}"
      console.warn "using #{max_leverage} instead"

      leverage = max_leverage

  ## check for strings on leverage field, this way we can convert
  ## MAX / HALF / QUARTER to actual numbers
  if typeof leverage is 'string'

    leverage = leverage.toUpperCase()

    if [ 'MAX', 'HALF', 'QUARTER' ].indexOf( leverage ) isnt -1

      if leverage is 'MAX'
        leverage = max_leverage

      if leverage is 'HALF'
        leverage = max_leverage / 2

      if leverage is 'QUARTER'
        leverage = max_leverage / 4

      leverage = Number leverage.toFixed( 2 )

  if tp_is_percentage = take_profit.indexOf( "%" ) isnt -1
    take_profit = take_profit.replace( "%", "" )
  else
    tp_is_points = ( take_profit[0] is '-' or take_profit[0] is '+' )

  take_profit = Number take_profit

  if sl_is_percentage = stop_loss.indexOf("%") isnt -1
    stop_loss = stop_loss.replace( "%", "" )
  else
    sl_is_points = ( stop_loss[0] is '-' or stop_loss[0] is '+' )

  stop_loss = Number stop_loss

  if direction is 'short' and ( tp_is_percentage or tp_is_points )
    take_profit = -take_profit

  if direction is 'short' and ( sl_is_percentage or sl_is_points )
    stop_loss = -stop_loss

  if tp_is_percentage
    take_profit = add_percentage( price, leverage, take_profit )

  if sl_is_percentage
    stop_loss   = add_percentage( price, leverage, stop_loss )

  if tp_is_points
    take_profit = add_points( symbol, price, take_profit )

  if sl_is_points
    stop_loss   = add_points( symbol, price, stop_loss )

  params = {}

  if take_profit
    params.take_profit = Number take_profit.toFixed( info.decimals )

  if stop_loss
    params.stop_loss   = Number stop_loss.toFixed( info.decimals )

  if leverage
    params.leverage = leverage

  return params
