_                          = require 'lodash'
User                       = require 'data/models/User'
UsersLoadedEvent           = require 'events/load/UsersLoadedEvent'
FollowersByCardLoadedEvent = require 'events/load/FollowersByCardLoadedEvent'
Request                    = require 'data/framework/Request'

class LoadFollowersByCardRequest extends Request

  constructor: (@cardid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/followers"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    users = _.map result.users, (doc) -> new User(doc)
    publish new UsersLoadedEvent(users)
    publish new FollowersByCardLoadedEvent(@cardid, users)

module.exports = LoadFollowersByCardRequest
