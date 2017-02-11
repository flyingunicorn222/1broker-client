should = require( "should" )

Client = require '../src/client'
key    = require '../_key'

describe '1Broker-client', ->

  # client instance
  client = null

  #beforeEach ->

  client = new Client( key )

  describe 'Calculate Stop Loss and Take Profit using Percentage', ->

    it 'calculate correct SL and TP for SHORT with 1x leverage', ->

      params = client.calculate "eurusd", 1, 1, "short", "-10%", '20%'

      params.leverage.should.equal    1
      params.stop_loss.should.equal   1.1
      params.take_profit.should.equal 0.8

    it 'calculate correct SL and TP for SHORT with 100x leverage', ->

      params = client.calculate "eurusd", 100, 1, "short", "-10%", '20%'

      params.leverage.should.equal    100
      params.stop_loss.should.equal   1.001
      params.take_profit.should.equal 0.998

    it 'calculate correct SL and TP for LONG with 1x leverage', ->

      params = client.calculate "eurusd", 1, 1, "long", "-10%", '20%'

      params.leverage.should.equal    1
      params.stop_loss.should.equal   0.9
      params.take_profit.should.equal 1.2

    it 'calculate correct SL and TP for LONG with 100x leverage', ->

      params = client.calculate "eurusd", 100, 1, "long", "-10%", '20%'

      params.leverage.should.equal    100
      params.stop_loss.should.equal   0.999
      params.take_profit.should.equal 1.002


  describe 'Calculate Stop Loss and Take Profit using Points', ->

    it 'calculate correct SL and TP for LONG', ->

      params = client.calculate "eurusd", 1, 1, "long", "-100", '+200'

      params.stop_loss.should.equal   0.999
      params.take_profit.should.equal 1.002

    it 'calculate correct SL and TP for SHORT', ->

      params = client.calculate "eurusd", 1, 1, "short", "-100", '+200'

      params.stop_loss.should.equal   1.001
      params.take_profit.should.equal 0.998


  describe 'Calculate Stop Loss and Take Profit using absolute values', ->

    it 'calculate correct SL and TP for LONG', ->

      params = client.calculate "eurusd", 40, 1, "long", "0.95", '1.2'

      params.stop_loss.should.equal   0.95
      params.take_profit.should.equal 1.2

    it 'calculate correct SL and TP for SHORT', ->

      params = client.calculate "eurusd", 123, 1, "short", "1.2", '0.9'

      params.stop_loss.should.equal   1.2
      params.take_profit.should.equal 0.9

  describe 'Calculate Stop Loss and Take Profit using mixed values', ->

    it 'calculate correct SL and TP for LONG using Points and Percentage', ->

      params = client.calculate "eurusd", 100, 1, "long", "-200", '20%'

      params.stop_loss.should.equal   0.998
      params.take_profit.should.equal 1.002

    it 'calculate correct SL and TP for SHORT using Points and Percentage', ->

      params = client.calculate "eurusd", 1, 1, "short", "-200", '20%'

      params.stop_loss.should.equal   1.002
      params.take_profit.should.equal 0.8

    it 'calculate correct SL and TP for LONG using Percentage and Points', ->

      params = client.calculate "eurusd", 100, 1, "long", "-30%", '+300'

      params.stop_loss.should.equal   0.997
      params.take_profit.should.equal 1.003

    it 'calculate correct SL and TP for SHORT using Percentage and Points', ->

      params = client.calculate "eurusd", 1, 1, "short", "-30%", '+300'

      params.stop_loss.should.equal   1.3
      params.take_profit.should.equal 0.997

    it 'calculate correct SL and TP for LONG using Percentage and Fixed value', ->

      params = client.calculate "eurusd", 100, 1, "long", "-30%", '0.999'

      params.stop_loss.should.equal   0.997
      params.take_profit.should.equal 0.999

    it 'calculate correct SL and TP for SHORT using Percentage and Fixed value', ->

      params = client.calculate "eurusd", 1, 1, "short", "-30%", '0.997'

      params.stop_loss.should.equal   1.3
      params.take_profit.should.equal 0.997

    it 'calculate correct SL and TP for LONG using Points and Fixed value', ->

      params = client.calculate "eurusd", 100, 1, "long", "-450", '0.999'

      params.stop_loss.should.equal   0.9955
      params.take_profit.should.equal 0.999

    it 'calculate correct SL and TP for SHORT using Points and Fixed value', ->

      params = client.calculate "eurusd", 1, 1, "short", "-450", '0.997'

      params.stop_loss.should.equal   1.0045
      params.take_profit.should.equal 0.997

    it 'calculate correct SL and TP for LONG using Fixed value and Percentage', ->

      params = client.calculate "eurusd", 100, 1, "long", "0.999", '10%'

      params.stop_loss.should.equal   0.999
      params.take_profit.should.equal 1.001

    it 'calculate correct SL and TP for SHORT using Fixed value and Percentage', ->

      params = client.calculate "eurusd", 1, 1, "short", "1.002", '30%'

      params.stop_loss.should.equal   1.002
      params.take_profit.should.equal 0.7

    it 'calculate correct SL and TP for LONG using Fixed value and Points', ->

      params = client.calculate "eurusd", 100, 1, "long", "0.999", '+200'

      params.stop_loss.should.equal   0.999
      params.take_profit.should.equal 1.002

    it 'calculate correct SL and TP for SHORT using Fixed value and Points', ->

      params = client.calculate "eurusd", 1, 1, "short", "1.002", '+200'

      params.stop_loss.should.equal   1.002
      params.take_profit.should.equal 0.998

  describe 'Calculate Leverage using string values', ->

    it 'calculate correct leverage using MAX', ->

      params = client.calculate "eurusd", 'max', 1, "long", "-200", '20%'

      params.leverage.should.equal 200

    it 'calculate correct leverage using HALF', ->

      params = client.calculate "eurusd", 'half', 1, "long", "-200", '20%'

      params.leverage.should.equal 100

    it 'calculate correct leverage using QUARTER', ->

      params = client.calculate "eurusd", 'quarter', 1, "long", "-200", '20%'

      params.leverage.should.equal 50

  # wont test
  if not key

    console.warn "NOTE: Due to the lack of API KEY no API methods are being tested"
    return

  describe 'call free methods', ->

    it 'should get market quotes', ( done ) ->

      params = symbols: [ 'EURUSD', 'USDJPY' ]

      client.market.quotes params, ( error, result ) ->

        should( error ).be.null

        result.error.should.equal false

        result.response[0].symbol.should.be.ok
        result.response[0].bid.should.be.ok
        result.response[0].ask.should.be.ok

        result.response[1].symbol.should.be.ok
        result.response[1].bid.should.be.ok
        result.response[1].ask.should.be.ok

        done()


    it 'should get user overview', ( done ) ->

      client.user.overview ( error, result ) ->

        should( error ).be.null

        result.error.should.equal false

        result.response.username.should.be.ok
        result.response.email.should.be.ok
        result.response.balance.should.be.ok
        result.response.orders_worth.should.be.ok
        result.response.positions_worth.should.be.ok
        result.response.net_worth.should.be.ok
        result.response.orders_open.should.be.ok
        result.response.positions_open.should.be.ok

        done()


  describe 'call paid methods', ->

    it 'should long eurusd and get insuficient funds error', ( done ) ->

      # wait 5 seconds for answer
      @timeout 2000

      params =
        symbol    : 'EURUSD'
        margin    : 0.01
        direction : 'long'
        leverage  : 1
        order_type: 'market'

      client.order.create params, ( error, result ) ->

        should( error ).be.null

        # insufficient funds
        result.error.should.be.true
        result.error_code.should.equal 502

        done()


