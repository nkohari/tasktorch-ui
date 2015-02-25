superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class AddFollowerToCardRequest extends Request

  constructor: (@cardid, @userid) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/cards/#{@cardid}/followers")
    .send({user: @userid})
    .end (res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = AddFollowerToCardRequest
