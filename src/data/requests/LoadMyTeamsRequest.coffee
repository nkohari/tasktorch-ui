_                  = require 'lodash'
Team               = require 'data/models/Team'
TeamsLoadedEvent   = require 'events/load/TeamsLoadedEvent'
MyTeamsLoadedEvent = require 'events/load/MyTeamsLoadedEvent'
Request            = require 'data/framework/Request'

class LoadMyTeamsRequest extends Request

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/me/teams"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    teams = _.map result.teams, (doc) -> new Team(doc)
    publish new TeamsLoadedEvent(teams)
    publish new MyTeamsLoadedEvent(teams)

module.exports = LoadMyTeamsRequest
