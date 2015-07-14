_                     = require 'lodash'
superagent            = require 'superagent'
Request               = require 'data/framework/Request'
User                  = require 'data/models/User'
UsersLoadedEvent      = require 'events/load/UsersLoadedEvent'
UsersByOrgLoadedEvent = require 'events/load/UsersByOrgLoadedEvent'

class LoadUsersByOrgRequest extends Request

  constructor: (@orgid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{@orgid}/members"))
    .withCredentials()
    .end (err, res) =>
      users = _.map res.body.users, (data) -> new User(data)
      eventQueue.publish new UsersLoadedEvent(users)
      eventQueue.publish new UsersByOrgLoadedEvent(@orgid, users)

module.exports = LoadUsersByOrgRequest
