_                     = require 'lodash'
superagent            = require 'superagent'
Request               = require 'data/framework/Request'
Team                  = require 'data/models/Team'
TeamsLoadedEvent      = require 'events/load/TeamsLoadedEvent'
TeamsByOrgLoadedEvent = require 'events/load/TeamsByOrgLoadedEvent'

class LoadTeamsByOrgRequest extends Request

  constructor: (@orgid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{@orgid}/teams", (res) =>
      teams = _.map res.body.teams, (data) -> new Team(data)
      eventQueue.publish new TeamsLoadedEvent(teams)
      eventQueue.publish new TeamsByOrgLoadedEvent(@orgid, teams)

module.exports = LoadTeamsByOrgRequest
