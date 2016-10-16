A node.js wrapper for [1broker](https://1broker.com/m/r.php?i=11468) api client.

Implements all API methods, also implements % Stop Loss and Take Profit when
creating Market or Limit orders.

installing
====

````npm install --save 1broker-client````

Unfortunately new versions might break backwards
compatibility so please make sure you specify a version on your package.json
file.

Basics:
====

All functions take "callback" as last parameter:

````javascript
OneBroker = require( "1broker-client" )

client = OneBroker( "YOU_API_KEY" )

client.account.overview( function( error, overview ) {
  if( error ) return console.error( error );

  console.log( overview );
} );
````

Functions which need parameters will take them as object, for instance:

````javascript

client.market.quotes({
  symbols: "BTCUSD,GOLD"
}, function( error, quotes ) {
  console.log( quotes );
});

````

All methods from the API have been implemented

````javascript
client.account.bitcoin_deposit_address( callback )
client.account.info( callback )
client.account.overview( callback )

client.market.detail( params, callback )
client.market.get_bars( params, callback )
client.market.list( callback )
client.market.quotes( params, callback )

client.order.cancel( params, callback )
client.order.create( params, callback )
client.order.list_open( params, callback )

client.position.edit( params, callback )
client.position.list_history( params, callback )
client.position.list_open( params, callback )
````

For full [API documentation](https://1broker.com/?c=api_documentation) please refer to the [Official API](https://1broker.com/?c=api_documentation)

EXAMPLES
====

Simple examples are provided on the [/examples](/examples) folder, including
the % Stop Loss and Take Profit syntax

I'm also developing extra functions, called ["helpers"](/src/helpers) which will
hopefully simplify the implementation of mechanical tasks.

TODO
====

- [x] Simple implementation
- [x] Examples
- [ ] Extra methods ( long, short, close, reverse, [...] )
- [ ] Documentation
- [ ] Tests
- [ ] Parameters validation
- [ ] Please [create an issue](https://github.com/flyingunicorn222/1broker-client/issues/new) if you need something else

Contributing
====
The source code is also pretty simple and self explainatory so feel free
to edit and submit a pull request.

In case you find an issue, have a request or recommendation feel free to [open
an issue](https://github.com/flyingunicorn222/1broker-client/issues/new), it will be highly appreciated.

You can also [donate to support this library and more freebies!](https://blockchain.info/address/1767DuD8teMeeTV2DtPviqMYE1G13169x3)

Feel free to send me a message on reddit, I'm [flyingunicorn222](https://www.reddit.com/user/flyingunicorn222)

Thank You!

Disclaimer
====
 - By default when creating an order this library will use my referral_id,
which is a means i'll receive a small amount of BTC from [1broker](https://1broker.com/m/r.php?i=11468)! It would be great if you could keep it this way!

 - [1broker](https://1broker.com/m/r.php?i=11468) links on this documentation
also constains my referral link
