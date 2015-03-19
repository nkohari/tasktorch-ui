_                       = require 'lodash'
superagent              = require 'superagent'
Request                 = require 'data/framework/Request'
Card                    = require 'data/models/Card'
CardsLoadedEvent        = require 'events/load/CardsLoadedEvent'
CardsByStageLoadedEvent = require 'events/load/CardsByStageLoadedEvent'

class LoadCardsByStageRequest extends Request

  constructor: (@stageid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/stages/#{@stageid}/cards", (res) =>
      cards = _.map res.body.cards, (data) -> new Card(data)
      eventQueue.publish new CardsLoadedEvent(cards)
      eventQueue.publish new CardsByStageLoadedEvent(@stageid, cards)

module.exports = LoadCardsByStageRequest
