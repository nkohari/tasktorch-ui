superagent       = require 'superagent'
Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class RemoveCardFromGoalRequest extends Request

  constructor: (@goalid, @cardid) ->

  execute: (eventQueue) ->
    superagent.del("/api/#{Environment.orgid}/cards/#{@cardid}/goals/#{@goalid}")
    .end (res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardChangedEvent(card)

module.exports = RemoveCardFromGoalRequest
