request = require 'request'

module.exports = ( config, method, params, callback ) ->

  # console.log 'got config ->', config
  # console.log 'method ->', method
  # console.log 'params ->', params

  # if only 3 arguments are sent assume the last one is the callback
  if params and not callback?
    callback = params
    params   = null

  url = "#{config.url}/#{method}.php?token=#{config.api_key}"

  if config.referral_id?
    url += "&referral_id=#{config.referral_id}"

  if config.pretty
    url += "&pretty=1"

  if params? then url += params

  console.log "calling url ->", url

  request url: url, ( error, response, body ) ->

    if error
      return callback?( error )

    try
      parsed = JSON.parse( body )
    catch e
      console.log "error parsing body as json, dumping body"
      console.log body
      return callback?( e )

    if body.error

      console.log 3
      return callback?( body )

    if body.warning

      console.log "Got Warning from API, dumping full response"
      console.log body

    callback?( null, body )