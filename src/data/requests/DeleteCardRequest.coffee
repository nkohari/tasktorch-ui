Card             = require 'data/models/Card'
CardDeletedEvent = require 'events/delete/CardDeletedEvent'
Request          = require 'data/framework/Request'

class DeleteCardRequest extends Request

  constructor: (@cardid) ->

  create: (agent) ->
    agent
    .del(@urlFor("/#{Environment.orgid}/cards/#{@cardid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardDeletedEvent(card)

module.exports = DeleteCardRequest
