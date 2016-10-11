OneBroker = require "../src/client"
api_key   = require "./api_key"

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
  position_id : 919085
  market_close: true

client.position_edit( params, callback )


