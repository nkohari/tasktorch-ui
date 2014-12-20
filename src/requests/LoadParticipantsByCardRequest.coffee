_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
UsersLoadedEvent = require 'events/load/UsersLoadedEvent'

class LoadParticipantsByCardRequest extends Request

  constructor: (@cardId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/cards/#{@cardId}/participants", (res) =>
      {users} = res.body
      eventBus.publish new UsersLoadedEvent(users)

module.exports = LoadParticipantsByCardRequest
