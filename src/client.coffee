_ = require 'lodash'

default_config = require './config'

module.exports = ( api_key, referral_id ) ->

  if not api_key
    console.warn "Warning: api_key is required in order to call 1Broker's API"
    return

  config = _.defaults { api_key, referral_id }, default_config

  # for each API method we will create a function that receives
  # the config as first parameter, this way we don't have to
  # worry about sending API_KEY and other options on each call
  api = ( file ) ->
    _.partial( require( "./api/#{file}"), config )

  client =
    user :
      details                : api 'user/details'
      overview               : api 'user/overview'
      bitcoin_deposit_address: api 'user/bitcoin_deposit_address'
      transaction_log        : api 'user/transaction_log'
      quota_status           : api 'user/quota_status'

    order    :
      open                   : api 'order/open'
      create                 : api 'order/create'
      cancel                 : api 'order/cancel'

    position :
      open                   : api 'position/open'
      edit                   : api 'position/edit'
      close                  : api 'position/close'
      close_cancel           : api 'position/close_cancel'
      history                : api 'position/history'

    market   :
      categories             : api 'market/categories'
      list                   : api 'market/list'
      details                : api 'market/details'
      quotes                 : api 'market/quotes'
      bars                   : api 'market/bars'
      ticks                  : api 'market/ticks'


    # borrow info from module itself
    info      : module.exports.info
    add       : module.exports.add
    get       : module.exports.get
    calculate : module.exports.calculate

  # for each helper method we will create a function that receives
  # the client as first parameter, same we did with the API methods
  # but this time sending the whole client as first parameter
  helper = ( file ) ->
    _.partial( require( "./helpers/#{file}"), client )

  # mapping helper functions
  client.long  = helper 'long'
  client.short = helper 'short'


  return client

# exports info and symbols statically so we don't need to create an instace
# with keys in order to list symbols or see market details
module.exports.info =
  symbols               : require './info/symbols'
  details               : require './info/details'

module.exports.add =
  points     : require './helpers/add/points'
  percentage : require './helpers/add/percentage'

module.exports.get =
  points     : require './helpers/get/points'
  percentage : require './helpers/get/percentage'

module.exports.calculate = require './helpers/calculate'
