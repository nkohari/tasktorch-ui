_                         = require 'lodash'
Team                      = require 'data/models/Team'
Request                   = require 'data/framework/Request'
TeamsLoadedEvent          = require 'events/load/TeamsLoadedEvent'
SuggestedTeamsLoadedEvent = require 'events/load/SuggestedTeamsLoadedEvent'

class LoadSuggestedTeamsRequest extends Request

  constructor: (@phrase) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/teams?suggest=#{@phrase}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    teams = _.map result.teams, (doc) -> new Team(doc)
    publish new TeamsLoadedEvent(teams)
    publish new SuggestedTeamsLoadedEvent(@phrase, teams)

module.exports = LoadSuggestedTeamsRequest
