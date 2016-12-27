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
  symbol    : 'EURUSD'
  resolution: 86400 # daily candle
  date_start: '2016-12-26T00:00:00Z'


client.market.bars( params, callback )
