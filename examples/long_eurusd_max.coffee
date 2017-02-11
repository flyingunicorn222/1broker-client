OneBroker = require '../src/client'
client    = OneBroker( require "../_key" )

callback = ( error, response ) ->

  if error
    console.log "got error"
    console.log error
    return

  console.log response

params =
  symbol    : 'EURUSD'
  margin    : 0.01
  direction : 'long'
  leverage  : 'MAX' # MAX = maximum leverage, HALF = 50%, QUARTER = 25%
  order_type: 'market'

client.order.create( params, callback )
