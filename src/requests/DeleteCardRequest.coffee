superagent       = require 'superagent'
Request          = require 'framework/Request'
CardChangedEvent = require 'events/change/CardChangedEvent'

class DeleteCardRequest extends Request

  constructor: (@card) ->

  execute: ->
    superagent.del("/api/#{@card.organization}/cards/#{@card.id}")
    .end()

module.exports = DeleteCardRequest