superagent       = require 'superagent'
Team             = require 'data/models/Team'
TeamChangedEvent = require 'events/change/TeamChangedEvent'
Request          = require 'data/framework/Request'

class AddLeaderToTeamRequest extends Request

  constructor: (@teamid, @userid) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/teams/#{@teamid}/leaders")
    .send({user: @userid})
    .end (res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamChangedEvent(team)

module.exports = AddLeaderToTeamRequest