User             = require 'data/models/User'
UsersLoadedEvent = require 'events/load/UsersLoadedEvent'
Request          = require 'data/framework/Request'

class LoadUserRequest extends Request

  constructor: (@userid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/members/#{@userid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    user = new User(result.user)
    publish new UsersLoadedEvent([user])

module.exports = LoadUserRequest
