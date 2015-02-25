superagent       = require 'superagent'
Team             = require 'data/models/Team'
Request          = require 'data/framework/Request'
TeamsLoadedEvent = require 'events/load/TeamsLoadedEvent'

class LoadTeamRequest extends Request

  constructor: (@teamid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/teams/#{@teamid}", (res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamsLoadedEvent([team])

module.exports = LoadTeamRequest
