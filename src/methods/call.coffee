request = require 'request'

module.exports = ( config, method, params, callback ) ->

  # console.log 'got config ->', config
  # console.log 'method ->', method
  # console.log 'params ->', params

  url = "#{config.url}/#{method}.php?token=#{config.api_key}"

  if config.referral_id?
    url += "&referral_id=#{config.referral_id}"

  if config.pretty
    url += "&pretty=1"

  if params? then url += params

  console.log "calling url ->", url

  request url: url, ( error, response, body ) ->

    if error
      callback?( error )

      return

    try
      body = JSON.parse( body )
    catch e
      return callback?( error )

    console.log 'got body ->', body
