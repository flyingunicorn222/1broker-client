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
````javascript
OneBroker = require( "1broker-client" )

client = OneBroker( YOU_API_KEY )

client.account_overview( ( error, overview ) {
  if( error ) return console.error error;

  console.log( overview );
} );
````

For full [API documentation](https://1broker.com/?c=api_documentation) please refer to the [Official API](https://1broker.com/?c=api_documentation)


Disclaimer
====
 - By default when creating an order this library will use my refferal_id, 
which is a means i'll receive a small amount of BTC from [1broker](https://1broker.com/m/r.php?i=11468)! It would be great if you could keep it this way!

 - [1broker](https://1broker.com/m/r.php?i=11468) links on this documentation
also constains my refferal link

 - If you would like to support the development of this library and other
 freebies, pleae make a donation to this [BTC address](https://blockchain.info/address/1767DuD8teMeeTV2DtPviqMYE1G13169x3)

 ![Donate]
 (https://blockchain.info/qr?data=1767DuD8teMeeTV2DtPviqMYE1G13169x3&size=200)

Thank You!