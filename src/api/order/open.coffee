call = require '../call'

module.exports = ( config, callback ) ->

  call config, 'order/open', callback
