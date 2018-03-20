# download market details so we can know
# - number of decimal points
# - overnight long and short percent
# - maximun leverage and amount
# - name, category and type of each market

fs     = require 'fs'
key    = require '../_key'
P      = require 'bluebird'
Client = require '../src/client'

get_symbols = require './get_symbols'

fetch_details = ->

  client = new Client key

  details = {}

  console.log "Getting list of symbols"

  symbols = await get_symbols()

  get_details = P.promisify client.market.details

  # get a copy of all symbols
  all_symbols = [].concat symbols.all

  for symbol in all_symbols

    console.log "Fetching #{symbol} details"

    response = await get_details { symbol }

    d = response.response

    d.maximum_leverage               = Number d.maximum_leverage
    d.maximum_amount                 = Number d.maximum_amount
    d.overnight_charge_long_percent  = Number d.overnight_charge_long_percent
    d.overnight_charge_short_percent = Number d.overnight_charge_short_percent
    d.decimals                       = Number d.decimals

    details[ symbol ] = d

  details = JSON.stringify details, null, 2

  path = __dirname + "/../src/info/details.json"

  fs.writeFileSync path, details

  symbols = JSON.stringify symbols, null, 2

  path = __dirname + "/../src/info/symbols.json"

  fs.writeFileSync path, symbols

do fetch_details

###
  details = {}

  end = ->
    details = JSON.stringify( details, null, 2 )

    path = __dirname + "/../src/info/details.json"

    fs.writeFileSync( path, details )

    console.log 'wrote file ', path

  console.log 'Fetching all market details'

  next = ->

    symbol = symbols.pop()

    if not symbol

      end()

      return

    console.log "Fetching #{symbol} details"

    client.market.details symbol: symbol, ( error, result ) ->

      if error

        console.error 'error fetching details for', symbol
        console.error error

        return

      d = result.response

      d.maximum_leverage               = Number d.maximum_leverage
      d.maximum_amount                 = Number d.maximum_amount
      d.overnight_charge_long_percent  = Number d.overnight_charge_long_percent
      d.overnight_charge_short_percent = Number d.overnight_charge_short_percent
      d.decimals                       = Number d.decimals

      details[ symbol ] = d
      next()

  next()
###
