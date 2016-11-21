call = require '../call'

module.exports = ( config, callback ) ->

  call config, 'user/bitcoin_deposit_address', callback
