superagent       = require 'superagent'
Team             = require 'data/models/Team'
TeamCreatedEvent = require 'events/create/TeamCreatedEvent'
Request          = require 'data/framework/Request'

class CreateTeamRequest extends Request

  constructor: (@name) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/teams")
    .send({@name})
    .end (res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamCreatedEvent(team)

module.exports = CreateTeamRequest
