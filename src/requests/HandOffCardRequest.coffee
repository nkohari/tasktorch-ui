_                  = require 'lodash'
superagent         = require 'superagent'
Header             = require 'framework/enums/Header'
Request            = require 'framework/Request'
CardHandedOffEvent = require 'events/CardHandedOffEvent'

class HandOffCardRequest extends Request

  constructor: (@card, @recipient, @message) ->

  execute: (context, eventBus) ->

    payload = {@message}
    payload[@recipient.kind] = @recipient.item.id

    superagent.put("/api/#{@card.organization}/cards/#{@card.id}/handoff")
    .set(Header.Socket, eventBus.getSocketId())
    .send(payload)
    .end (res) =>
      {card, oldStack, newStack} = res.body
      eventBus.publish new CardHandedOffEvent(@card.id, card, oldStack, newStack)

module.exports = HandOffCardRequest
