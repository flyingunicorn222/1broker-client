details = require '../../info/details'

module.exports = ( symbol, price, points ) ->

  points = Number points
  price  = Number price

  decimals = details[ symbol.toUpperCase() ].decimals

  points   = points * ( 1 / Math.pow( 10, decimals ) )

  price + points

