1Broker-client
===

A node.js wrapper for [1broker](https://1broker.com/?c=en/action/r&i=11468) api client, this package is used by [@telebroker_bot](https://telegram.me/telebroker_bot) for telegram!


Implements all [1broker API](https://1broker.com/?c=api_documentation) methods and also a couple extra features:

 - % Stop Loss and Take Profit when creating Market or Limit orders.
 - Option to use "MAX", "HALF" or "QUARTER" as leverage, so it will dynamically adjust based on market MAX leverage.
 - Market information is cached on [details.json](https://github.com/flyingunicorn222/1broker-client/blob/v2/src/info/details.json) allowing quick and smart calculations, for instance:
   - How many points you making in your position?
     - see [client.get.points( symbol, entry, current_price )](https://github.com/flyingunicorn222/1broker-client/blob/v2/src/helpers/get/points.coffee)
   - At what value will a reach that many points?
     - see [client.add.points( symbol, value, points )](https://github.com/flyingunicorn222/1broker-client/blob/v2/src/helpers/add/points.coffee)
   - How many percent a given difference represents with a given leverage?
     - see [client.get.percentage( entry, difference, leverage )](https://github.com/flyingunicorn222/1broker-client/blob/v2/src/helpers/get/percentage.coffee)

telegram bot
====
All this functionality from this library is available through [@telebroker_bot](https://telegram.me/telebroker_bot) for telegram.

I also created a [thread on reddit](https://www.reddit.com/r/1Broker/comments/582eks/you_can_buy_and_sell_on_1broker_directly_from/) to speak about it, i'll hopefully keep improving the bot and keeping reddit up to date with the features.

Feel free to contact me there or [open a new issue](https://github.com/flyingunicorn222/1broker-client/issues/new)!


installing
====

````npm install --save 1broker-client````

Unfortunately new versions might break backwards
compatibility so please make sure you specify a version on your package.json
file.

basics
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

Most methods from the API V2 have been implemented


````javascript
client.user.bitcoin_deposit_address( callback )
client.user.details( callback )
client.user.overview( callback )

client.market.details( params, callback )
client.market.get_bars( params, callback )
client.market.list( callback )
client.market.quotes( params, callback )

client.order.cancel( params, callback )
client.order.create( params, callback )
client.order.list_open( params, callback )

client.position.edit( params, callback )
client.position.history( params, callback )
client.position.open( params, callback )

client.position.close( position_id, callback )
client.position.close_cancel( position_id, callback )
````

For full [API documentation](https://1broker.com/?c=en/content/api-documentation) please refer to the [Official API](https://1broker.com/?c=en/content/api-documentation)

examples
====

Simple examples are provided on the [/examples](https://github.com/flyingunicorn222/1broker-client/tree/v1/examples) folder, including
the % Stop Loss and Take Profit syntax.

Before running the examples you will need:

 - [1broker Account](https://1broker.com/?c=en/action/r&i=11468)

 - Api Token ( Create one in [Settings](https://1broker.com/?u1=account_settings) )

 - [Coffee-Script](http://coffeescript.org/) ```npm install coffee-script --global```

 - Download the example files

```bash
$ git clone https://github.com/flyingunicorn222/1broker-client.git
$ cd 1broker-client/
$ npm install
$ cd examples
```

 - Edit [_key file](https://github.com/flyingunicorn222/1broker-client/blob/v1/examples/_key.coffee) and add your key between the quotes

```bash
# examples/_key.coffee
module.exports ='YOUR_TOKEN_GOES_HERE'
```

Now you can run examples, for instance:
```bash
$coffee long_eurusd.coffee
```
or
```bash
$coffee short_btcusd.coffee
```
Examples source code is pretty simple, please [go ahead](https://github.com/flyingunicorn222/1broker-client/blob/v1/examples/) an explore!

===

I'm also developing more extra functions, called ["helpers"](https://github.com/flyingunicorn222/1broker-client/tree/v1/src/helpers) which will
hopefully simplify the implementation of mechanical tasks.

todo
====

- [x] Simple implementation
- [x] Examples
- [ ] Extra methods ( long, short, close, reverse, [...] )
- [ ] Documentation
- [ ] Tests
- [ ] Parameters validation
- [ ] Please [create an issue](https://github.com/flyingunicorn222/1broker-client/issues/new) if you need something else

contributing
====
The source code is also pretty simple and self explainatory so feel free
to edit and submit a pull request.

In case you find an issue, have a request or recommendation feel free to [open
an issue](https://github.com/flyingunicorn222/1broker-client/issues/new), it will be highly appreciated.

You can also [donate to support this library and more freebies!](https://blockchain.info/address/1767DuD8teMeeTV2DtPviqMYE1G13169x3)

Feel free to send me a message on reddit, I'm [flyingunicorn222](https://www.reddit.com/user/flyingunicorn222)

Thank You!

disclaimer
====
 - By default when creating an order this library will use my referral_id,
which means I'll receive a small amount of BTC from [1broker](https://1broker.com/?c=en/action/r&i=11468)
when you create an order! It would be great if you could keep it this way! If you don't agree update the value on the config file.

 - [1broker](https://1broker.com/?c=en/action/r&i=11468) links on this documentation
also constains my referral link
