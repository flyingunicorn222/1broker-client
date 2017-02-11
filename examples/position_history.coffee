OneBroker = require '../src/client'
client    = OneBroker( require "../_key" )

callback = ( error, response ) ->

  if error
    console.log "got error"
    console.log error
    return

  console.log response

# this will return the last 20 closed positions
params =
  limit : 20
  offset: 0

client.position.history( params, callback )

