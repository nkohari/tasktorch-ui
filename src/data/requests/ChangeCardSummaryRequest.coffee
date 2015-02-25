superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class ChangeCardSummaryRequest extends Request

  constructor: (@cardid, @summary) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/cards/#{@cardid}/summary")
    .send {@summary}
    .end (res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = ChangeCardSummaryRequest
