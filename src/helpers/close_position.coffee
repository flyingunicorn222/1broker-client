module.exports = ( client, position_id, callback ) ->

  params =
    position_id  : Number( position_id )
    market_close : true

  client.position.edit( params, callback )
