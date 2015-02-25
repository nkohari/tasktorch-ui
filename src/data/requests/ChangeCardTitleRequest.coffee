superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class ChangeCardTitleRequest extends Request

  constructor: (@cardid, @title) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/cards/#{@cardid}/title")
    .send {@title}
    .end (res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = ChangeCardTitleRequest
