superagent       = require 'superagent'
Team             = require 'data/models/Team'
TeamChangedEvent = require 'events/change/TeamChangedEvent'
Request          = require 'data/framework/Request'

class AddMemberToTeamRequest extends Request

  constructor: (@teamid, @userid) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/members"))
    .withCredentials()
    .send({user: @userid})
    .end (err, res) =>
      team = new Team(res.body.team)
      eventQueue.publish new TeamChangedEvent(team)

module.exports = AddMemberToTeamRequest
