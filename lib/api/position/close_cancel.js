// Generated by CoffeeScript 1.11.1
var call;

call = require('../call');

module.exports = function(config, position_id, callback) {
  var params;
  params = {
    position_id: position_id
  };
  return call(config, 'position/close_cancel', params, callback);
};