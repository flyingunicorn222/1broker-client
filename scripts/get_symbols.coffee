P = require 'bluebird'
_ = require 'lodash'

key    = require '../_key'
Client = require '../src/client'

one_broker = new Client key

module.exports = P.promisify ( done ) ->

  #console.time 'fetching 1broker markets'

  one_broker.market.categories ( error, response ) ->

    if error then return done 'error fetchin markets'

    markets = response.response

    get_symbols = P.promisify one_broker.market.list

    list = for market in markets

      get_symbols category: market

    P.map list, ( response ) -> _.map response.response, (i) -> i.symbol
    .then  ( markets ) ->
      #console.timeEnd 'fetching 1broker markets'
      done null, _.flatten markets
    .catch ( error )   ->
      #console.timeEnd 'fetching 1broker markets'
      done error
