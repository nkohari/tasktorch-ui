Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class CompleteCardRequest extends Request

  constructor: (@cardid) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/complete"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = CompleteCardRequest
