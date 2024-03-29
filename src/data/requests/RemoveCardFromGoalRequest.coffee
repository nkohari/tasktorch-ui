Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class RemoveCardFromGoalRequest extends Request

  constructor: (@goalid, @cardid) ->

  create: (identity, agent) ->
    agent
    .del(@urlFor("/#{identity.orgid}/cards/#{@cardid}/goals/#{@goalid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = RemoveCardFromGoalRequest
