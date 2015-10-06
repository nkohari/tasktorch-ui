Profile             = require 'data/models/Profile'
ProfileChangedEvent = require 'events/change/ProfileChangedEvent'
Request             = require 'data/framework/Request'

class ChangeMyBioRequest extends Request

  constructor: (@bio) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/me/profile/bio"))
    .withCredentials()
    .send {@bio}

  onSuccess: (result, publish) ->
    profile = new Profile(result.profile)
    publish new ProfileChangedEvent(profile)

module.exports = ChangeMyBioRequest
