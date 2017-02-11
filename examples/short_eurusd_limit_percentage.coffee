OneBroker = require '../src/client'
client    = OneBroker( require "../_key" )

callback = ( error, response ) ->

  if error
    console.log "got error"
    console.log error
    return

  console.log response

params =
  symbol      : 'EURUSD'
  margin      : 0.01
  direction   : 'short'
  leverage    : 1
  order_type  : 'limit'
  # when doing limit orders, that's how you specify the entry_price
  order_type_parameter : '1.0'
  stop_loss   : '-10%'
  take_profit : '50%'

client.order.create( params, callback )
