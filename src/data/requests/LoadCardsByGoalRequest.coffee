_                      = require 'lodash'
Request                = require 'data/framework/Request'
Card                   = require 'data/models/Card'
CardsLoadedEvent       = require 'events/load/CardsLoadedEvent'
CardsByGoalLoadedEvent = require 'events/load/CardsByGoalLoadedEvent'

class LoadCardsByGoalRequest extends Request

  constructor: (@goalid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/goals/#{@goalid}/cards"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    cards = _.map result.cards, (data) -> new Card(data)
    publish new CardsLoadedEvent(cards)
    publish new CardsByGoalLoadedEvent(@goalid, cards)

module.exports = LoadCardsByGoalRequest
