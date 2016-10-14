call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'position/edit', params, callback
