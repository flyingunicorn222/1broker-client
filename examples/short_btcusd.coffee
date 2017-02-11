OneBroker = require '../src/client'
client    = OneBroker( require "../_key" )

callback = ( error, response ) ->

  if error
    console.log "got error"
    console.log error
    return

  console.log response

params =
  symbol    : 'BTCUSD'
  margin    : 0.01
  direction : 'short'
  leverage  : 1
  order_type: 'market'

client.order.create( params, callback )

