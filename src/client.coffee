glob   = require 'glob'
_      = require 'lodash'

default_config = require './config'

module.exports = ( api_key, referral_id ) ->

  if not api_key
    console.error "Error: api_key is required to do 1broker API calls"
    return null

  config = _.defaults { api_key, referral_id }, default_config

  # For each file we find in the "./methods" folder we will export a function
  # which will receive the config as first argument by default

  files  = glob.sync "#{__dirname}/methods/*.*"
  client = {}

  for file in files
    name         = file.split("/").pop().split(".")[0]
    funktion     = require file
    client[name] = _.partial funktion, config

  return client