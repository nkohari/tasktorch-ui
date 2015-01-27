_                = require 'lodash'
superagent       = require 'superagent'
Header           = require 'framework/enums/Header'
Request          = require 'framework/Request'
CardCreatedEvent = require 'events/create/CardCreatedEvent'

class CreateCardRequest extends Request

  constructor: (@org, @kind) ->

  execute: (context, eventBus, callback) ->
    superagent.post("/api/#{@org}/cards")
    .set(Header.Socket, eventBus.getSocketId())
    .send({@kind})
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardCreatedEvent(card)
      callback(null, card)

module.exports = CreateCardRequest
