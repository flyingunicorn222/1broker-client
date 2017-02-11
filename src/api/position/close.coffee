call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'position/close', params, callback
