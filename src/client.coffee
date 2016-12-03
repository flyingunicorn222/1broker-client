_      = require 'lodash'

default_config = require './config'

module.exports = ( api_key, referral_id ) ->

  if not api_key
    console.error "Error: api_key is required to do 1broker API calls"
    return null

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

    market   :
      details                : api 'market/details'
      get_bars               : api 'market/get_bars'
      list                   : api 'market/list'
      quotes                 : api 'market/quotes'

    order    :
      cancel                 : api 'order/cancel'
      create                 : api 'order/create'
      list_open              : api 'order/open'

    position :
      edit                   : api 'position/edit'
      history                : api 'position/history'
      open                   : api 'position/open'
      close                  : api 'position/close'
      close_cancel           : api 'position/close_cancel'

    info:
      symbols               : require './info/symbols'
      details               : require './info/details'

  # for each helper method we will create a function that receives
  # the client as first parameter, same we did with the API methods
  # but this time sending the whole client as first parameter
  helper = ( file ) ->
    _.partial( require( "./helpers/#{file}"), client )

  # mapping helper functions
  client.long  = helper 'long'
  client.short = helper 'short'
  client.close = helper 'close'

  return client
