superagent       = require 'superagent'
Card             = require 'data/models/Card'
Request          = require 'data/framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class MoveCardRequest extends Request

  constructor: (@cardid, @stackid, @position) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/move"))
    .withCredentials()
    .send {stack: @stackid, @position}
    .end (err, res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = MoveCardRequest
