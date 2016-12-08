module.exports = ( value, leverage, percentage ) ->

  percentage = 1 + ( percentage / 100 / leverage )

  return value * percentage
