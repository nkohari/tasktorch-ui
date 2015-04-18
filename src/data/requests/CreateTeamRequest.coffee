superagent       = require 'superagent'
Team             = require 'data/models/Team'
TeamCreatedEvent = require 'events/create/TeamCreatedEvent'
Request          = require 'data/framework/Request'

class CreateTeamRequest extends Request

  constructor: (@name, @purpose, @members, @leaders) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/teams")
    .send {@name, @purpose, @members, @leaders}
    .end (res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamCreatedEvent(team)

module.exports = CreateTeamRequest
