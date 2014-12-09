_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
TeamsLoadedEvent = require 'events/TeamsLoadedEvent'

class LoadAllTeamsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/teams", (res) =>
      {teams} = res.body
      eventBus.publish new TeamsLoadedEvent(teams)

module.exports = LoadAllTeamsRequest
