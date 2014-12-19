superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/CardChangedEvent'

class SetCardTitleRequest extends Request

  constructor: (@card, @title) ->

  execute: (context, eventBus) ->
    superagent.put("/api/#{@card.organization}/cards/#{@card.id}/title")
    .send {@title}
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = SetCardTitleRequest
