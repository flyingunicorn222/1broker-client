# download market details so we can know
# - number of decimal points
# - overnight long and short percent
# - maximun leverage and amount
# - name, category and type of each market

fs     = require 'fs'
key    = require '../_key'
Client = require '../src/client'

client = new Client key

symbols = client.info.symbols.all
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

      console.error 'error fetching details'
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
