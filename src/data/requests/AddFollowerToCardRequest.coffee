superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class AddFollowerToCardRequest extends Request

  constructor: (@cardid, @userid) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/followers"))
    .withCredentials()
    .send({user: @userid})
    .end (err, res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = AddFollowerToCardRequest
