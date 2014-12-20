superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class SetCardBodyRequest extends Request

  constructor: (@card, @body) ->

  execute: ->
    superagent.put("/api/#{@card.organization}/cards/#{@card.id}/body")
    .send {@body}
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = SetCardBodyRequest
