_                         = require 'lodash'
User                      = require 'data/models/User'
Request                   = require 'data/framework/Request'
UsersLoadedEvent          = require 'events/load/UsersLoadedEvent'
SuggestedUsersLoadedEvent = require 'events/load/SuggestedUsersLoadedEvent'

class LoadSuggestedUsersRequest extends Request

  constructor: (@phrase) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/members?suggest=#{@phrase}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    users = _.map result.users, (doc) -> new User(doc)
    publish new UsersLoadedEvent(users)
    publish new SuggestedUsersLoadedEvent(@phrase, users)

module.exports = LoadSuggestedUsersRequest
