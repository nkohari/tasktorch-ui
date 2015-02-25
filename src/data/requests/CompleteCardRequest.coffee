superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class CompleteCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/cards/#{@cardid}/complete")
    .end (res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = CompleteCardRequest
