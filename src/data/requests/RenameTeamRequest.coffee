Team             = require 'data/models/Team'
Request          = require 'data/framework/Request'
TeamChangedEvent = require 'events/change/TeamChangedEvent'

class RenameTeamRequest extends Request

  constructor: (@teamid, @name) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/name"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    team = new Team(result.team)
    publish new TeamChangedEvent(team)

module.exports = RenameTeamRequest
