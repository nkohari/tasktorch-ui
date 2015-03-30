superagent       = require 'superagent'
Team             = require 'data/models/Team'
Request          = require 'data/framework/Request'
TeamChangedEvent = require 'events/change/TeamChangedEvent'

class RenameTeamRequest extends Request

  constructor: (@teamid, @name) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/teams/#{@teamid}/name")
    .send {@name}
    .end (res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamChangedEvent(team)

module.exports = RenameTeamRequest
