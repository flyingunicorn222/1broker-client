call = require './call'

module.exports = ( config, callback ) ->

  call config, 'account/bitcoin_deposit_address', callback