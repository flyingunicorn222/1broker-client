call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'order/cancel', params, callback
