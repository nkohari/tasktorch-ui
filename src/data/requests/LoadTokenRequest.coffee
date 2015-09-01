Token             = require 'data/models/Token'
Request           = require 'data/framework/Request'
TokensLoadedEvent = require 'events/load/TokensLoadedEvent'

class LoadTokenRequest extends Request

  constructor: (@tokenid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/tokens/#{@tokenid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    token = new Token(result.token)
    publish new TokensLoadedEvent([token])

module.exports = LoadTokenRequest
