call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'market/detail', params, callback
