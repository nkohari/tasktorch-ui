Card             = require 'data/models/Card'
CardCreatedEvent = require 'events/create/CardCreatedEvent'
Request          = require 'data/framework/Request'

class CreateCardRequest extends Request

  constructor: (@orgid, @kindid) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/cards"))
    .withCredentials()
    .send {kind: @kindid}
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardCreatedEvent(card)

module.exports = CreateCardRequest
