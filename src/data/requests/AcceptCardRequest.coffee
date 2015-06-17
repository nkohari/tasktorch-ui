superagent       = require 'superagent'
Request          = require 'data/framework/Request'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'

class AcceptCardRequest extends Request

  constructor: (@cardid, @preempt) ->


  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/accept"))
    .withCredentials()
    .send {@preempt}
    .end (err, res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = AcceptCardRequest
