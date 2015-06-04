superagent       = require 'superagent'
Request          = require 'data/framework/Request'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'

class RestoreCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/cards/#{@cardid}/restore")
    .end (res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = RestoreCardRequest
