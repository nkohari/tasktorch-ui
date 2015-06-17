_                      = require 'lodash'
superagent             = require 'superagent'
Request                = require 'data/framework/Request'
Card                   = require 'data/models/Card'
CardsLoadedEvent       = require 'events/load/CardsLoadedEvent'
CardsByGoalLoadedEvent = require 'events/load/CardsByGoalLoadedEvent'

class LoadCardsByGoalRequest extends Request

  constructor: (@goalid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/goals/#{@goalid}/cards"))
    .withCredentials()
    .end (err, res) =>
      cards = _.map res.body.cards, (data) -> new Card(data)
      eventQueue.publish new CardsLoadedEvent(cards)
      eventQueue.publish new CardsByGoalLoadedEvent(@goalid, cards)

module.exports = LoadCardsByGoalRequest
