superagent       = require 'superagent'
Team             = require 'data/models/Team'
TeamDeletedEvent = require 'events/delete/TeamDeletedEvent'
Request          = require 'data/framework/Request'

class DeleteTeamRequest extends Request

  constructor: (@teamid) ->

  execute: (eventQueue) ->
    superagent.del("/api/#{Environment.orgid}/teams/#{@teamid}")
    .end (res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamDeletedEvent(team)

module.exports = DeleteTeamRequest
