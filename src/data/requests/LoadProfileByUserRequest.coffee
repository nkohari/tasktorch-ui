_                   = require 'lodash'
Request             = require 'data/framework/Request'
Profile             = require 'data/models/Profile'
ProfilesLoadedEvent = require 'events/load/ProfilesLoadedEvent'

class LoadProfileByUserRequest extends Request

  constructor: (@userid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/users/#{@userid}/profile"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    profile = new Profile(result.profile)
    publish new ProfilesLoadedEvent([profile])

module.exports = LoadProfileByUserRequest
