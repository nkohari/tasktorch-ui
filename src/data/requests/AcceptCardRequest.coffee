Request          = require 'data/framework/Request'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'

class AcceptCardRequest extends Request

  constructor: (@cardid, @preempt) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/cards/#{@cardid}/accept"))
    .withCredentials()
    .send {@preempt}

  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = AcceptCardRequest
