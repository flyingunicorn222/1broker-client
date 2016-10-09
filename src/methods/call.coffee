request = require 'request'

module.exports = ( config, method, params, callback ) ->

  console.log 'got config ->', config
  console.log 'method ->', method
  console.log 'params ->', params

  on_error    = ( error )    -> 
    console.log "error calling api", error
    callback?( error )

  on_response = ( response, body ) -> 
    console.log "succes calling api", response

    callback?( null, response )

  url = "#{config.url}/#{method}.php?token=#{config.api_key}"

  if params?
    url += params

  console.log "calling url ->", url

  request
    .get( url )
    .on( "error"   , on_error )
    .on( "response", on_response )