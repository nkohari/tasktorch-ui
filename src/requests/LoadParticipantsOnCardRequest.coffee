superagent        = require 'superagent'
Request           = require 'framework/Request'
UsersLoadedEvent = require 'events/UsersLoadedEvent'

class LoadParticipantsOnCardRequest extends Request

  constructor: (@cardId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/cards/#{@cardId}/participants", (res) =>
      {users} = res.body
      eventBus.publish new UsersLoadedEvent(users)

module.exports = LoadParticipantsOnCardRequest
