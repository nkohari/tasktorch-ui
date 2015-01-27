superagent       = require 'superagent'
Request          = require 'framework/Request'
TeamsLoadedEvent = require 'events/load/TeamsLoadedEvent'

class LoadTeamRequest extends Request

  constructor: (@teamId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgId}/teams/#{@teamId}", (res) =>
      {team} = res.body
      eventBus.publish new TeamsLoadedEvent([team])

module.exports = LoadTeamRequest
