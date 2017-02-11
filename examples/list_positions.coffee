OneBroker = require '../src/client'
client    = OneBroker( require "../_key" )

callback = ( error, response ) ->

  if error
    console.log "got error"
    console.log error
    return

  console.log response

client.position.open( callback )

