Big = require 'big.js'

module.exports = ( price, amount, leverage ) ->

  Number(amount / price * 100 * leverage).toFixed(2)


