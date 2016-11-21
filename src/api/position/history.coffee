call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'position/history', params, callback
