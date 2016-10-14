call = require '../call'

module.exports = ( config, callback ) ->

  call config, 'order/list_open', callback
