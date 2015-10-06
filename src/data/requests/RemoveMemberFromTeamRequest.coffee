Team             = require 'data/models/Team'
TeamChangedEvent = require 'events/change/TeamChangedEvent'
Request          = require 'data/framework/Request'

class RemoveMemberFromTeamRequest extends Request

  constructor: (@teamid, @userid) ->

  create: (identity, agent) ->
    agent
    .del(@urlFor("/#{identity.orgid}/teams/#{@teamid}/members/#{@userid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    team = new Team(result.team)
    publish new TeamChangedEvent(team)

module.exports = RemoveMemberFromTeamRequest
