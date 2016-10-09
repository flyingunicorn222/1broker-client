OneBroker = require "../src/client"
api_key   = require "./api_key"

if not api_key

  console.log "Can't test without API_KEY !"
  console.log "Please update tests/api_key.coffee"
  return

client = OneBroker( api_key )

callback = ( error, response ) ->

  if error
    console.log "got error"
    console.log error
    return

  console.log response

# client.account_overview callback
# client.account_info callback
# client.account_bitcoin_deposit_address callback

# params = 
#   symbol     : 'BTCUSD'
#   margin     : 0.01
#   direction  : 'long'
#   leverage   : 1
#   order_type : 'Market'

# client.order_create params, callback

client.order_list_open callback

# client.position_list_history callback

# params = 
#   position_id: 123
#   stop_loss  : 0

# client.position_edit params, callback

# client.market_list callback

# client.market_detail { symbol: "BTCUSD" }, callback

# client.market_quotes { symbols: "BTCUSD,GOLD" }, callback