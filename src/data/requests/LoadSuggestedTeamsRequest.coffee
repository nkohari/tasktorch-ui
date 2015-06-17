_                         = require 'lodash'
superagent                = require 'superagent'
Team                      = require 'data/models/Team'
Request                   = require 'data/framework/Request'
TeamsLoadedEvent          = require 'events/load/TeamsLoadedEvent'
SuggestedTeamsLoadedEvent = require 'events/load/SuggestedTeamsLoadedEvent'

class LoadSuggestedTeamsRequest extends Request

  constructor: (@phrase) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/teams?suggest=#{@phrase}"))
    .withCredentials()
    .end (err, res) =>
      teams = _.map res.body.teams, (doc) -> new Team(doc)
      eventQueue.publish new TeamsLoadedEvent(teams)
      eventQueue.publish new SuggestedTeamsLoadedEvent(@phrase, teams)

module.exports = LoadSuggestedTeamsRequest
