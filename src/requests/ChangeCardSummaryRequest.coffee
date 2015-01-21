superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class ChangeCardSummaryRequest extends Request

  constructor: (@card, @summary) ->

  execute: ->
    superagent.post("/api/#{@card.organization}/cards/#{@card.id}/summary")
    .send {@summary}
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = ChangeCardSummaryRequest
