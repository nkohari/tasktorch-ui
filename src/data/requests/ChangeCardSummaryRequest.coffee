Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class ChangeCardSummaryRequest extends Request

  constructor: (@cardid, @summary) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/cards/#{@cardid}/summary"))
    .withCredentials()
    .send {@summary}

  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = ChangeCardSummaryRequest
