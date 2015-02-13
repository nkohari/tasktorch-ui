superagent       = require 'superagent'
Request          = require 'framework/Request'
CardsLoadedEvent = require 'events/load/CardsLoadedEvent'

class LoadMyFollowedCardsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/me/following", (res) =>
      {cards} = res.body
      eventBus.publish new CardsLoadedEvent(cards)

module.exports = LoadMyFollowedCardsRequest
