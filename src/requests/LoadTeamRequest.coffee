superagent       = require 'superagent'
Request          = require 'framework/Request'
TeamsLoadedEvent = require 'events/load/TeamsLoadedEvent'

class LoadTeamRequest extends Request

  constructor: (@teamid) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/teams/#{@teamid}", (res) =>
      {team} = res.body
      eventBus.publish new TeamsLoadedEvent([team])

module.exports = LoadTeamRequest
