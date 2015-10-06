Card             = require 'data/models/Card'
Request          = require 'data/framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class RemoveFollowerFromCardRequest extends Request

  constructor: (@cardid, @userid) ->

  create: (identity, agent) ->
    agent
    .del(@urlFor("/#{identity.orgid}/cards/#{@cardid}/followers/#{@userid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = RemoveFollowerFromCardRequest
