_                      = require 'lodash'
Request                = require 'data/framework/Request'
Team                   = require 'data/models/Team'
TeamsLoadedEvent       = require 'events/load/TeamsLoadedEvent'
TeamsByUserLoadedEvent = require 'events/load/TeamsByUserLoadedEvent'

class LoadTeamsByUserRequest extends Request

  constructor: (@userid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/members/#{@userid}/teams"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    teams = _.map result.teams, (data) -> new Team(data)
    publish new TeamsLoadedEvent(teams)
    publish new TeamsByUserLoadedEvent(@userid, teams)

module.exports = LoadTeamsByUserRequest
