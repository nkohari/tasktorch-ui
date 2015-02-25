superagent       = require 'superagent'
Card             = require 'data/models/Card'
Request          = require 'data/framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class RemoveFollowerFromCardRequest extends Request

  constructor: (@cardid, @userid) ->

  execute: (eventQueue) ->
    superagent.del("/api/#{Environment.orgid}/cards/#{@cardid}/followers/#{@userid}")
    .end (res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = RemoveFollowerFromCardRequest
