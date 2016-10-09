1broker-client
=====

A very simple [1broker](https://1broker.com/m/r.php?i=11468) api client, in case 
you have any suggestions or problems get in touch through github issues.

installing
====

````npm install --save 1broker-client````

Unfortunately new versions of this package might be break backwards
compatibility so please make sure you specify a version on your package.json
file.

Examples:
====

All functions take "callback" as last parameter:

````javascript
OneBroker = require( "1broker-client" )

client = OneBroker( YOU_API_KEY )

client.account_overview( ( error, overview ) {
  if( error ) return console.error error;

  console.log( overview );
} );
````

Functions which need parameters will take them as object, for instance:

````javascript

client.market_quotes({
  symbols: "BTCUSD,GOLD"
}, function( error, quotes ) {
  console.log( quotes );
});

````

All methods from the API have been implemented

````javascript
client.account_bitcoin_deposit_address( callback )
client.account_info( callback )
client.account_overview( callback )

client.market_detail( params, callback )
client.market_get_bars( params, callback )
client.market_list( callback )
client.market_quotes( params, callback )

client.order_cancel( params, callback )
client.order_create( params, callback )
client.order_list_open( params, callback )

client.position_edit( params, callback )
client.position_list_history( params, callback )
client.position_list_open( params, callback )
````

For full [API documentation](https://1broker.com/?c=api_documentation) please refer to the [Official API](https://1broker.com/?c=api_documentation)


Contributing
====
Please just make a pull request or open an issue, any comment or recommendation
will be highly appreciated.

You can also support [Donate to support this library and more freebies](https://blockchain.info/address/1767DuD8teMeeTV2DtPviqMYE1G13169x3)

Thank You!

Disclaimer
====
 - By default when creating an order this library will use my refferal_id, 
which is a means i'll receive a small amount of BTC from [1broker](https://1broker.com/m/r.php?i=11468)! It would be great if you could keep it this way!

 - [1broker](https://1broker.com/m/r.php?i=11468) links on this documentation
also constains my refferal link