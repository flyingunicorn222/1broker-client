call = require './call'

module.exports = ( config, params, callback ) ->

  call config, 'order/create', params, callback