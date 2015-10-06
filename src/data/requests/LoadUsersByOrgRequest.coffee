_                     = require 'lodash'
Request               = require 'data/framework/Request'
User                  = require 'data/models/User'
UsersLoadedEvent      = require 'events/load/UsersLoadedEvent'
UsersByOrgLoadedEvent = require 'events/load/UsersByOrgLoadedEvent'

class LoadUsersByOrgRequest extends Request

  constructor: (@orgid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{@orgid}/members"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    users = _.map result.users, (data) -> new User(data)
    publish new UsersLoadedEvent(users)
    publish new UsersByOrgLoadedEvent(@orgid, users)

module.exports = LoadUsersByOrgRequest
