P = require 'bluebird'
_ = require 'lodash'

key    = require '../_key'
Client = require '../src/client'

one_broker = new Client key

module.exports = ->

  console.time 'fetching 1broker markets'

  # we will return a map of symbols
  symbols     = {}
  all_symbols = [] # list with all symbols

  # get categories
  get_categories = P.promisify one_broker.market.categories

  response = await get_categories()

  categories = response.response

  # get symbols for each category
  list_markets = P.promisify one_broker.market.list

  for category in categories

    response = await list_markets { category }

    category = category.toLowerCase()

    symbols[ category ] = []

    for market in response.response

      symbols[ category ].push market.symbol

      all_symbols.push market.symbol

  symbols.all = all_symbols

  return symbols
