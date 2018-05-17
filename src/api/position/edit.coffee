call = require '../call'

module.exports = ( config, params, callback ) ->

  if params.take_profit is 0
    delete params.take_profit
  if params.stop_loss is 0
    delete params.stop_loss

  call config, 'position/edit', params, callback
