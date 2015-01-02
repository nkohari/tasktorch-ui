_          = require 'lodash'
superagent = require 'superagent'
Header     = require 'framework/enums/Header'
Request    = require 'framework/Request'

class PassCardRequest extends Request

  constructor: (@card, @recipient, @message) ->

  execute: (context, eventBus) ->

    payload = {@message}
    payload[@recipient.kind] = @recipient.item.id

    superagent.put("/api/#{@card.organization}/cards/#{@card.id}/pass")
    .set(Header.Socket, eventBus.getSocketId())
    .send(payload)
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = PassCardRequest
