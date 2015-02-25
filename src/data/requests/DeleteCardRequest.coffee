superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardDeletedEvent = require 'events/delete/CardDeletedEvent'
Request          = require 'data/framework/Request'

class DeleteCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.del("/api/#{Environment.orgid}/cards/#{@cardid}")
    .end (res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardDeletedEvent(card)

module.exports = DeleteCardRequest
