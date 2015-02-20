superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class FollowCardRequest extends Request

  constructor: (@card, @userid) ->

  execute: ->
    superagent.post("/api/#{@card.org}/cards/#{@card.id}/followers")
    .send({user: @userid})
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = FollowCardRequest
