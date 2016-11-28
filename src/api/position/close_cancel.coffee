call = require '../call'

module.exports = ( config, position_id, callback ) ->

  params = position_id: position_id

  call config, 'position/close_cancel', params, callback
