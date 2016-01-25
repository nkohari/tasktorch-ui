Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class ChangeCardDueDateRequest extends Request

  constructor: (@cardid, @due) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/cards/#{@cardid}/due"))
    .withCredentials()
    .send {@due}

  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = ChangeCardDueDateRequest
