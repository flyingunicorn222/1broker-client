call = require '../call'

module.exports = ( config, callback ) ->

  call config, 'user/quota_status', callback
