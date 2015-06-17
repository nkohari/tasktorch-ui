superagent       = require 'superagent'
Team             = require 'data/models/Team'
TeamChangedEvent = require 'events/change/TeamChangedEvent'
Request          = require 'data/framework/Request'

class RemoveMemberFromTeamRequest extends Request

  constructor: (@teamid, @userid) ->

  execute: (eventQueue) ->
    superagent.del(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/members/#{@userid}"))
    .withCredentials()
    .end (err, res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamChangedEvent(team)

module.exports = RemoveMemberFromTeamRequest
