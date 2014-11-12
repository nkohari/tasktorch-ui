_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
TeamsLoadedEvent = require 'events/TeamsLoadedEvent'

class LoadAllTeamsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/teams", (res) =>
      eventBus.publish new TeamsLoadedEvent(res.body)

module.exports = LoadAllTeamsRequest
