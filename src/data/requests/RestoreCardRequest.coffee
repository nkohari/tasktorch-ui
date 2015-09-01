Request          = require 'data/framework/Request'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'

class RestoreCardRequest extends Request

  constructor: (@cardid) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/restore"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = RestoreCardRequest
