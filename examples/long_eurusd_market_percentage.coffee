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
  direction   : 'long'
  leverage    : 'max'
  order_type  : 'market'
  stop_loss   : '10%'
  take_profit : '50%'

client.order.create( params, callback )
