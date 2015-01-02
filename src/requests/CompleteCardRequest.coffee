superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class CompleteCardRequest extends Request

  constructor: (@card) ->

  execute: ->
    superagent.post("/api/#{@card.organization}/cards/#{@card.id}/complete")
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = CompleteCardRequest
