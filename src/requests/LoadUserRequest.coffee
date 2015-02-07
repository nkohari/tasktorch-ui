superagent       = require 'superagent'
Request          = require 'framework/Request'
UsersLoadedEvent = require 'events/load/UsersLoadedEvent'

class LoadUserRequest extends Request

  constructor: (@userid) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/members/#{@userid}", (res) =>
      {user} = res.body
      eventBus.publish new UsersLoadedEvent([user])

module.exports = LoadUserRequest
