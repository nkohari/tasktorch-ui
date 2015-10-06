Team             = require 'data/models/Team'
TeamCreatedEvent = require 'events/create/TeamCreatedEvent'
Request          = require 'data/framework/Request'

class CreateTeamRequest extends Request

  constructor: (@name, @purpose, @members, @leaders) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/teams"))
    .withCredentials()
    .send {@name, @purpose, @members, @leaders}
  
  onSuccess: (result, publish) ->
    team = new Team(result.team)
    publish new TeamCreatedEvent(team)

module.exports = CreateTeamRequest
