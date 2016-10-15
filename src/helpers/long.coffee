module.exports = ( client, symbol, margin = 0.01, leverage = 1, callback ) ->

  params =
    symbol    : market
    margin    : margin
    direction : 'long'
    leverage  : leverage
    order_type: 'Market'

  client.order.create( params, callback )
