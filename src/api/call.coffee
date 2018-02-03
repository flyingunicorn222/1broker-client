request = require 'request'
details = require '../info/details'

module.exports = ( config, method, params, callback ) ->

  # if only 3 arguments are sent assume the last one is the callback
  if params and not callback?
    callback = params
    params   = null

  url = "#{config.url}/#{method}.php?token=#{config.api_key}"

  if config.referral_id? and not params?.referral_id
    url += "&referral_id=#{config.referral_id}"

  if params?.referral_id?
    url += "&referral_id=#{params.referral_id}"

    # delete since we already used and we don't want the parameter
    # to be repeated once we build the parameters string
    delete params.referral_id

  if config.pretty
    url += "&pretty=1"

  if params?
    for key, value of params
      #console.log "#{key}=#{value}"

      url += "&#{key}=#{value}"

  request { url: url, strictSSL: config.strictSSL }, ( error, response, body ) ->

    if error
      return callback?( error )

    if response.statusCode isnt 200
      callback? response
      return

    try
      parsed = JSON.parse( body )
    catch e
      console.log "1broker-client error parsing body as json, dumping body"
      console.log body
      return callback?( e )

    if parsed.error

      return callback?( parsed )

    if parsed.warning

    callback?( null, parsed )
