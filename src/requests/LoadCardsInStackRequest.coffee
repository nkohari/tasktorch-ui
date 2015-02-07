_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
CardsLoadedEvent = require 'events/load/CardsLoadedEvent'

class LoadCardsInStackRequest extends Request

  constructor: (@stackid) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/stacks/#{@stackid}/cards", (res) =>
      {cards} = res.body
      eventBus.publish new CardsLoadedEvent(cards)

module.exports = LoadCardsInStackRequest
