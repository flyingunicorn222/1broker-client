call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'position/close_cancel', params, callback
