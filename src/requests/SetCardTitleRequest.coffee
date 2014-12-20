superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class SetCardTitleRequest extends Request

  constructor: (@card, @title) ->

  execute: ->
    superagent.put("/api/#{@card.organization}/cards/#{@card.id}/title")
    .send {@title}
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = SetCardTitleRequest
