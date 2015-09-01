Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class AddCardToGoalRequest extends Request

  constructor: (@goalid, @cardid) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/goals"))
    .withCredentials()
    .send {goal: @goalid}

  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = AddCardToGoalRequest
