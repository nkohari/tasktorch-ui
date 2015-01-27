_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
UsersLoadedEvent = require 'events/load/UsersLoadedEvent'

class LoadFollowersByCardRequest extends Request

  constructor: (@cardId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgId}/cards/#{@cardId}/followers", (res) =>
      {users} = res.body
      eventBus.publish new UsersLoadedEvent(users)

module.exports = LoadFollowersByCardRequest
