call = require './call'

module.exports = ( config, callback ) ->

  call config, 'positions/list_history', callback