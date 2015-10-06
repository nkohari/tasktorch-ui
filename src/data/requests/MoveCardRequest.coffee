Card             = require 'data/models/Card'
Request          = require 'data/framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class MoveCardRequest extends Request

  constructor: (@cardid, @stackid, @position) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/cards/#{@cardid}/move"))
    .withCredentials()
    .send {stack: @stackid, @position}
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = MoveCardRequest
