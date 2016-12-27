call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'market/bars', params, callback
