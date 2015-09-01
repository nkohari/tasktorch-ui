_                       = require 'lodash'
Request                 = require 'data/framework/Request'
Card                    = require 'data/models/Card'
CardsLoadedEvent        = require 'events/load/CardsLoadedEvent'
CardsByStageLoadedEvent = require 'events/load/CardsByStageLoadedEvent'

class LoadCardsByStageRequest extends Request

  constructor: (@stageid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/stages/#{@stageid}/cards"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    cards = _.map result.cards, (data) -> new Card(data)
    publish new CardsLoadedEvent(cards)
    publish new CardsByStageLoadedEvent(@stageid, cards)

module.exports = LoadCardsByStageRequest
