# close all positions we have for a given market
module.exports = ( client, symbol, callback ) ->

  # fetch all positions for a given market

  client
