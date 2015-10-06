Profile             = require 'data/models/Profile'
ProfileChangedEvent = require 'events/change/ProfileChangedEvent'
Request             = require 'data/framework/Request'

class ChangeMyTitleRequest extends Request

  constructor: (@title) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/me/profile/title"))
    .withCredentials()
    .send {@title}

  onSuccess: (result, publish) ->
    profile = new Profile(result.profile)
    publish new ProfileChangedEvent(profile)

module.exports = ChangeMyTitleRequest
