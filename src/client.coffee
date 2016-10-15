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
    account  :
      bitcoin_deposit_address: api 'account/bitcoin_deposit_address'
      info                   : api 'account/info'
      overview               : api 'account/overview'
    market   :
      detail                 : api 'market/detail'
      get_bars               : api 'market/get_bars'
      list                   : api 'market/list'
      quotes                 : api 'market/quotes'
    order    :
      cancel                 : api 'order/cancel'
      create                 : api 'order/create'
      list_open              : api 'order/list_open'
    position :
      edit                   : api 'position/edit'
      list_history           : api 'position/list_history'
      list_open              : api 'position/list_open'

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
