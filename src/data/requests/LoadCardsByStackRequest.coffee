_                       = require 'lodash'
Request                 = require 'data/framework/Request'
Card                    = require 'data/models/Card'
CardsLoadedEvent        = require 'events/load/CardsLoadedEvent'
CardsByStackLoadedEvent = require 'events/load/CardsByStackLoadedEvent'

class LoadCardsByStackRequest extends Request

  constructor: (@stackid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/stacks/#{@stackid}/cards"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    cards = _.map result.cards, (data) -> new Card(data)
    publish new CardsLoadedEvent(cards)
    publish new CardsByStackLoadedEvent(@stackid, cards)

module.exports = LoadCardsByStackRequest
