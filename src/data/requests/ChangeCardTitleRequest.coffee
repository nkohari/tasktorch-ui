Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class ChangeCardTitleRequest extends Request

  constructor: (@cardid, @title) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/title"))
    .withCredentials()
    .send {@title}

  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = ChangeCardTitleRequest
