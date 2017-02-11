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
  resolution: 86400 # daily candle
  date_start: '2016-12-26T00:00:00Z'


client.market.bars( params, callback )
