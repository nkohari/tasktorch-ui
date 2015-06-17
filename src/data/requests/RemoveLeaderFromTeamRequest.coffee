superagent       = require 'superagent'
Team             = require 'data/models/Team'
TeamChangedEvent = require 'events/change/TeamChangedEvent'
Request          = require 'data/framework/Request'

class RemoveLeaderFromTeamRequest extends Request

  constructor: (@teamid, @userid) ->

  execute: (eventQueue) ->
    superagent.del(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/leaders/#{@userid}"))
    .withCredentials()
    .end (err, res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamChangedEvent(team)

module.exports = RemoveLeaderFromTeamRequest
