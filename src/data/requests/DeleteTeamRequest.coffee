superagent       = require 'superagent'
Team             = require 'data/models/Team'
TeamDeletedEvent = require 'events/delete/TeamDeletedEvent'
Request          = require 'data/framework/Request'

class DeleteTeamRequest extends Request

  constructor: (@teamid) ->

  execute: (eventQueue) ->
    superagent.del(@urlFor("/#{Environment.orgid}/teams/#{@teamid}"))
    .withCredentials()
    .end (err, res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamDeletedEvent(team)

module.exports = DeleteTeamRequest
