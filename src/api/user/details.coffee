call = require '../call'

module.exports = ( config, callback ) ->

  call config, 'user/details', callback
