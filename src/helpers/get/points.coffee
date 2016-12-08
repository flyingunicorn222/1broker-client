details = require '../../info/details.json'
Big = require 'big.js'

module.exports = ( symbol, entry, current_price ) ->

  decimals = details[ symbol.toUpperCase() ].decimals

  point_size = 1 / Math.pow( 10, decimals )

  Number new Big( current_price ).minus( entry ).div( point_size ).toFixed(1)

