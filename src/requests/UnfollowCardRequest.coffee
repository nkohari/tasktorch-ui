superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class UnfollowCardRequest extends Request

  constructor: (@card, @userid) ->

  execute: ->
    superagent.del("/api/#{@card.org}/cards/#{@card.id}/followers/#{@userid}")
    .end (res) =>
      {card} = res.body
      eventBus.publish new CardChangedEvent(card)

module.exports = UnfollowCardRequest
