call = require './call'

module.exports = ( config, callback ) ->

  call config, 'account/info', callback