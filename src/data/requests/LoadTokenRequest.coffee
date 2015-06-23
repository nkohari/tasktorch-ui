superagent        = require 'superagent'
Token             = require 'data/models/Token'
Request           = require 'data/framework/Request'
TokensLoadedEvent = require 'events/load/TokensLoadedEvent'

class LoadTokenRequest extends Request

  constructor: (@tokenid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/tokens/#{@tokenid}"))
    .withCredentials()
    .end (err, res) =>
      token = new Token(res.body.token)
      eventQueue.publish new TokensLoadedEvent([token])

module.exports = LoadTokenRequest
