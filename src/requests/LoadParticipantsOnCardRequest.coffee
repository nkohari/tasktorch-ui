superagent        = require 'superagent'
Request           = require 'framework/Request'
UsersLoadedEvent = require 'events/UsersLoadedEvent'

class LoadParticipantsOnCardRequest extends Request

  constructor: (@cardId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/cards/#{@cardId}/participants", (res) =>
      eventBus.publish new UsersLoadedEvent(res.body)

module.exports = LoadParticipantsOnCardRequest
