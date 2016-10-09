call = require './call'

module.exports = ( config, params, callback ) ->

  call config, 'market/get_bars', params, callback