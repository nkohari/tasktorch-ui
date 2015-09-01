Team             = require 'data/models/Team'
TeamChangedEvent = require 'events/change/TeamChangedEvent'
Request          = require 'data/framework/Request'

class AddMemberToTeamRequest extends Request

  constructor: (@teamid, @userid) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/members"))
    .withCredentials()
    .send({user: @userid})

  onSuccess: (result, publish) ->
    team = new Team(result.team)
    publish new TeamChangedEvent(team)

module.exports = AddMemberToTeamRequest
