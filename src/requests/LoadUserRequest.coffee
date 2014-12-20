superagent       = require 'superagent'
Request          = require 'framework/Request'
UsersLoadedEvent = require 'events/load/UsersLoadedEvent'

class LoadUserRequest extends Request

  constructor: (@userId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/members/#{@userId}", (res) =>
      {user} = res.body
      eventBus.publish new UsersLoadedEvent([user])

module.exports = LoadUserRequest
