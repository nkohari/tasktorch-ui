superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class PassCardRequest extends Request

  constructor: (@cardid, @recipient, @message) ->

  execute: (eventQueue) ->

    payload = {@message}
    payload[@recipient.type] = @recipient.item.id

    superagent.put(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/pass"))
    .withCredentials()
    .send(payload)
    .end (err, res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = PassCardRequest
