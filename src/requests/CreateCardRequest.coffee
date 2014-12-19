_                = require 'lodash'
superagent       = require 'superagent'
Header           = require 'framework/enums/Header'
Request          = require 'framework/Request'
CardCreatedEvent = require 'events/CardCreatedEvent'

class CreateCardRequest extends Request

  constructor: (@organization, @kind) ->

  execute: (context, eventBus, callback) ->
    superagent.post("/api/#{@organization}/cards")
    .set(Header.Socket, eventBus.getSocketId())
    .send({@kind})
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardCreatedEvent(card)
      callback(null, card)

module.exports = CreateCardRequest
