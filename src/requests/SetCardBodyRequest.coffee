superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/CardChangedEvent'

class SetCardBodyRequest extends Request

  constructor: (@card, @body) ->

  execute: (context, eventBus) ->
    superagent.put("/api/#{@card.organization}/cards/#{@card.id}/body")
    .send {@body}
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = SetCardBodyRequest
