Team             = require 'data/models/Team'
Request          = require 'data/framework/Request'
TeamsLoadedEvent = require 'events/load/TeamsLoadedEvent'

class LoadTeamRequest extends Request

  constructor: (@teamid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/teams/#{@teamid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    team = new Team(result.team)
    publish new TeamsLoadedEvent([team])

module.exports = LoadTeamRequest
