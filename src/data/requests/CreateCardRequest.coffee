superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardCreatedEvent = require 'events/create/CardCreatedEvent'
Request          = require 'data/framework/Request'

class CreateCardRequest extends Request

  constructor: (@orgid, @kindid) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{@orgid}/cards"))
    .withCredentials()
    .send({kind: @kindid})
    .end (err, res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardCreatedEvent(card)

module.exports = CreateCardRequest
