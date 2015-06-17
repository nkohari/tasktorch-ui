_                  = require 'lodash'
superagent         = require 'superagent'
Team               = require 'data/models/Team'
TeamsLoadedEvent   = require 'events/load/TeamsLoadedEvent'
MyTeamsLoadedEvent = require 'events/load/MyTeamsLoadedEvent'
Request            = require 'data/framework/Request'

class LoadMyTeamsRequest extends Request

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/me/teams"))
    .withCredentials()
    .end (err, res) =>
      teams = _.map res.body.teams, (doc) -> new Team(doc)
      eventQueue.publish new TeamsLoadedEvent(teams)
      eventQueue.publish new MyTeamsLoadedEvent(teams)

module.exports = LoadMyTeamsRequest
