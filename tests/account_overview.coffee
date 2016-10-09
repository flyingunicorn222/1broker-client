OneBroker = require "../src/client"
api_key   = require "./api_key"

if not api_key

  console.log "Can't test without API_KEY !"
  console.log "Please update tests/api_key.coffee"
  return

client = OneBroker( api_key )

client.account_overview();
