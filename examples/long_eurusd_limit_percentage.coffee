OneBroker = require "../src/client"
api_key   = require "./_key"

if not api_key

  console.log "Can't test without API_KEY !"
  console.log "Please update tests/api_key.coffee"
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
  leverage    : 20
  order_type  : 'limit'
  # when doing limit orders, that's how you specify the entry_price
  order_type_parameter : '1.0'
  stop_loss   : '10%'
  take_profit : '50%'

client.order.create( params, callback )
