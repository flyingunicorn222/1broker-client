1broker-client
=====

A very simple [1broker](https://1broker.com/m/r.php?i=11468) api client, in case 
you have any suggestions or problems get in touch through github issues.

Disclaimer: By default creating an order will use my refferal_id, which is a 
way of  supporting the development of this module which costs you nothing.

I would appreaciate if you would keep it this way !

Thank You

=====

Examples:

````javascript
OneBroker = require( "1broker-client" )

client = OneBroker( YOU_API_KEY )

client.account_overview( ( error, overview ) {
  if( error )
    return console.error error;

  console.log( overview );
} );
````