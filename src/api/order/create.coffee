call = require '../call'

module.exports = ( config, params, callback ) ->

  stop_loss   = params.stop_loss
  take_profit = params.take_profit

  params.leverage = params.leverage || 1
  params.margin   = params.margin   || 0.01

  is_percent = stop_loss?.indexOf( "%" ) isnt -1
  is_percent = is_percent || take_profit?.indexOf( "%" ) isnt -1

  # if not using or using absolute values for SL / TP
  if not is_percent

    return call config, 'order/create', params, callback

  if params.order_type is 'Limit'

    if params.direction is 'short'

      if take_profit?.indexOf?( "%" ) isnt -1
        take_profit = Number( take_profit.replace( "%", "" ) )

        take_profit = 1 - ( take_profit / 100 / params.leverage )

        take_profit = Number( params.order_type_parameter ) * take_profit

        params.take_profit = take_profit

      if stop_loss?.indexOf?( "%" ) isnt -1

        stop_loss = Number( stop_loss.replace( "%", "" ) )

        stop_loss = 1 + ( stop_loss / 100 / params.leverage )

        stop_loss = Number( params.order_type_parameter ) * stop_loss
        stop_loss = Number( stop_loss.toFixed(6) )

        params.stop_loss = stop_loss

    if params.direction is 'long'

      if take_profit?.indexOf?( "%" ) isnt -1
        take_profit = Number( take_profit.replace( "%", "" ) )

        take_profit =  1 + ( take_profit / 100 / params.leverage )

        take_profit = Number( params.order_type_parameter ) * take_profit
        take_profit = Number( take_profit.toFixed(6) )

        params.take_profit = take_profit

      if stop_loss?.indexOf?( "%" ) isnt -1
        stop_loss = Number( stop_loss.replace( "%", "" ) )

        stop_loss = 1 - ( stop_loss / 100 / params.leverage )

        stop_loss = Number( params.order_type_parameter ) * stop_loss
        stop_loss = Number( stop_loss.toFixed(6) )

        params.stop_loss = stop_loss

    call config, 'order/create', params, callback

  if params.order_type is 'Market'

    call config, 'market/quotes', { symbols: params.symbol }, ( error, result ) ->

      if error then return callback?( error )

      if params.direction is 'short'

        if take_profit?.indexOf?( "%" ) isnt -1

          take_profit = Number( take_profit.replace( "%", "" ) )

          take_profit = 1 - ( take_profit / 100 / params.leverage )

          take_profit = Number( result.response[0].bid ) * take_profit
          take_profit = Number( take_profit.toFixed(6) )

          params.take_profit = take_profit

        if stop_loss?.indexOf?( "%" ) isnt -1
          stop_loss = Number( stop_loss.replace( "%", "" ) )

          stop_loss = 1 + ( stop_loss / 100 / params.leverage )

          stop_loss = Number( result.response[0].bid ) * stop_loss
          stop_loss = Number( stop_loss.toFixed(6) )

          params.stop_loss = stop_loss

      if params.direction is 'long'

        if take_profit?.indexOf?( "%" ) isnt -1

          take_profit = Number( take_profit.replace( "%", "" ) )

          take_profit = 1 + ( take_profit / 100 / params.leverage )

          take_profit = Number( result.response[0].ask ) * take_profit
          take_profit = Number( take_profit.toFixed(6) )

          params.take_profit = take_profit

        if stop_loss?.indexOf?( "%" ) isnt -1
          stop_loss = Number( stop_loss.replace( "%", "" ) )

          stop_loss = 1 + ( stop_loss / 100 / params.leverage )

          stop_loss = Number( result.response[0].ask ) / stop_loss
          stop_loss = Number( stop_loss.toFixed(6) )

          params.stop_loss = stop_loss

      call config, 'order/create', params, callback
