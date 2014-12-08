_                   = require 'lodash'
superagent          = require 'superagent'
Request             = require 'framework/Request'
CardsLoadedEvent    = require 'events/CardsLoadedEvent'
HandoffsLoadedEvent = require 'events/HandoffsLoadedEvent'

class LoadCardsInInboxRequest extends Request

  constructor: (@stackId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/stacks/#{@stackId}/cards?expand=lastHandoff", (res) =>
      handoffs = _.compact _.map res.body, (card) -> card['_related'].lastHandoff
      cards    = _.map res.body, (card) -> _.omit(card, '_related')
      eventBus.publish new CardsLoadedEvent(cards)
      eventBus.publish new HandoffsLoadedEvent(handoffs) if handoffs.length > 0

module.exports = LoadCardsInInboxRequest
