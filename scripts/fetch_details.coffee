# download market details so we can know
# - number of decimal points
# - overnight long and short percent
# - maximun leverage and amount
# - name, category and type of each market

key    = require './_key'
client = require './src/client'

module.exports = ->

