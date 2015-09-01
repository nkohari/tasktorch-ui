Team             = require 'data/models/Team'
Request          = require 'data/framework/Request'
TeamsLoadedEvent = require 'events/load/TeamsLoadedEvent'

class LoadTeamRequest extends Request

  constructor: (@teamid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/teams/#{@teamid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    team = new Team(result.team)
    publish new TeamsLoadedEvent([team])

module.exports = LoadTeamRequest
