call = require '../call'

module.exports = ( config, params, callback ) ->

  call config, 'user/transaction_log', callback
