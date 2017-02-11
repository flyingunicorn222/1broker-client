call = require '../call'

module.exports = ( config, callback ) ->

  call config, 'market/categories', callback
