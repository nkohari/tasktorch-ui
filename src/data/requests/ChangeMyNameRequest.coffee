User             = require 'data/models/User'
UserChangedEvent = require 'events/change/UserChangedEvent'
Request          = require 'data/framework/Request'

class ChangeMyNameRequest extends Request

  constructor: (@name) ->

  create: (agent) ->
    agent
    .post(@urlFor("/me/name"))
    .withCredentials()
    .send {@name}

  onSuccess: (result, publish) ->
    card = new User(result.user)
    publish new UserChangedEvent(user)

module.exports = ChangeMyNameRequest
