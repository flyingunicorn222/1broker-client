call = require './call'

module.exports = ( config, params, callback ) ->

  call config, 'position/list_history', params, callback