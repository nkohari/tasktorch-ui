_                     = require 'lodash'
Request               = require 'data/framework/Request'
Team                  = require 'data/models/Team'
TeamsLoadedEvent      = require 'events/load/TeamsLoadedEvent'
TeamsByOrgLoadedEvent = require 'events/load/TeamsByOrgLoadedEvent'

class LoadTeamsByOrgRequest extends Request

  constructor: (@orgid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{@orgid}/teams"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    teams = _.map result.teams, (data) -> new Team(data)
    publish new TeamsLoadedEvent(teams)
    publish new TeamsByOrgLoadedEvent(@orgid, teams)

module.exports = LoadTeamsByOrgRequest
