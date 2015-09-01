Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class PassCardRequest extends Request

  constructor: (@cardid, @recipient, @message) ->

  create: (agent) ->

    payload = {@message}
    payload[@recipient.type] = @recipient.item.id

    agent
    .put(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/pass"))
    .withCredentials()
    .send(payload)
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = PassCardRequest
