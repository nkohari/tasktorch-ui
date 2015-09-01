Team             = require 'data/models/Team'
TeamDeletedEvent = require 'events/delete/TeamDeletedEvent'
Request          = require 'data/framework/Request'

class DeleteTeamRequest extends Request

  constructor: (@teamid) ->

  create: (agent) ->
    agent
    .del(@urlFor("/#{Environment.orgid}/teams/#{@teamid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    team = new Team(result.team)
    publish new TeamDeletedEvent(team)

module.exports = DeleteTeamRequest
