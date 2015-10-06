User             = require 'data/models/User'
UserChangedEvent = require 'events/change/UserChangedEvent'
Request          = require 'data/framework/Request'

class ChangeMyEmailRequest extends Request

  constructor: (@email) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/me/email"))
    .withCredentials()
    .send {@email}

  onSuccess: (result, publish) ->
    user = new User(result.user)
    publish new UserChangedEvent(user)

module.exports = ChangeMyEmailRequest
