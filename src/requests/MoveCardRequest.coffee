superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class MoveCardRequest extends Request

  constructor: (@card, @stackid, @position) ->

  execute: ->
    superagent.post("/api/#{@card.org}/cards/#{@card.id}/move")
    .send {stack: @stackid, @position}
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = MoveCardRequest
