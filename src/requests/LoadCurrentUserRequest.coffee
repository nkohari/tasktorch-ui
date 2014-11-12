superagent = require 'superagent'
Request = require 'framework/Request'
CurrentUserLoadedEvent = require 'events/CurrentUserLoadedEvent'

class LoadCurrentUserRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/me", (res) =>
      eventBus.publish new CurrentUserLoadedEvent(res.body)

module.exports = LoadCurrentUserRequest
