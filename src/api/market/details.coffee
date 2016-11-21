call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'market/details', params, callback
