superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class MoveCardToArchiveRequest extends Request

  constructor: (@card) ->

  execute: ->
    superagent.post("/api/#{@card.organization}/cards/#{@card.id}/archive")
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = MoveCardToArchiveRequest
