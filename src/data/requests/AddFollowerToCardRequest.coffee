Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class AddFollowerToCardRequest extends Request

  constructor: (@cardid, @userid) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/cards/#{@cardid}/followers"))
    .withCredentials()
    .send {user: @userid}

  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = AddFollowerToCardRequest
