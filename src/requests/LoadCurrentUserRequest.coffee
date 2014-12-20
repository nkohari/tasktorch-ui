superagent             = require 'superagent'
Request                = require 'framework/Request'
CurrentUserLoadedEvent = require 'events/load/CurrentUserLoadedEvent'

class LoadCurrentUserRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/me", (res) =>
      {user} = res.body
      eventBus.publish new CurrentUserLoadedEvent(user)

module.exports = LoadCurrentUserRequest
