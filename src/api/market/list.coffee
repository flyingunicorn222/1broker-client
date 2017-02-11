call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'market/list', params, callback
