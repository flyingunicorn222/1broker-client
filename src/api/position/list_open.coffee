call = require '../call'

module.exports = ( config, callback ) ->

  call config, 'position/list_open', callback
