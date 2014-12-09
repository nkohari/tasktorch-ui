_                   = require 'lodash'
superagent          = require 'superagent'
Request             = require 'framework/Request'
CardsLoadedEvent    = require 'events/CardsLoadedEvent'
HandoffsLoadedEvent = require 'events/HandoffsLoadedEvent'

class LoadCardsInInboxRequest extends Request

  constructor: (@stackId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/stacks/#{@stackId}/cards?expand=lastHandoff", (res) =>
      {cards} = res.body
      handoffs = _.values(res.body.related.handoffs)
      eventBus.publish new CardsLoadedEvent(cards)
      eventBus.publish new HandoffsLoadedEvent(handoffs) if handoffs?.length > 0

module.exports = LoadCardsInInboxRequest
