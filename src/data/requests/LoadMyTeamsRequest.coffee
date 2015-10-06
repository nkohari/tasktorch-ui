_                  = require 'lodash'
Team               = require 'data/models/Team'
TeamsLoadedEvent   = require 'events/load/TeamsLoadedEvent'
MyTeamsLoadedEvent = require 'events/load/MyTeamsLoadedEvent'
Request            = require 'data/framework/Request'

class LoadMyTeamsRequest extends Request

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/me/teams"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    teams = _.map result.teams, (doc) -> new Team(doc)
    publish new TeamsLoadedEvent(teams)
    publish new MyTeamsLoadedEvent(teams)

module.exports = LoadMyTeamsRequest
