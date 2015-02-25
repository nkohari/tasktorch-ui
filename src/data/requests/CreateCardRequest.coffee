superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardCreatedEvent = require 'events/create/CardCreatedEvent'
Request          = require 'data/framework/Request'

class CreateCardRequest extends Request

  constructor: (@orgid, @kindid) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{@orgid}/cards")
    .send({kind: @kindid})
    .end (res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardCreatedEvent(card)

module.exports = CreateCardRequest
