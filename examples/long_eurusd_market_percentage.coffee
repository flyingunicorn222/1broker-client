OneBroker = require "../src/client"
api_key   = require "../_key"

if not api_key

  console.log "Can't test without API_KEY !"
  console.log "Please update /_key.coffee"
  return

client = OneBroker( api_key )

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
