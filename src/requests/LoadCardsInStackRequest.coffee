_                 = require 'lodash'
superagent        = require 'superagent'
Request           = require 'framework/Request'
CardsLoadedEvent  = require 'events/CardsLoadedEvent'

class LoadCardsInStackRequest extends Request

  constructor: (@stackId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/stacks/#{@stackId}/cards", (res) =>
      {cards} = res.body
      eventBus.publish new CardsLoadedEvent(cards)

module.exports = LoadCardsInStackRequest
