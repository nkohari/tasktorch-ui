User             = require 'data/models/User'
UserChangedEvent = require 'events/change/UserChangedEvent'
Request          = require 'data/framework/Request'

class SetMyFlagRequest extends Request

  constructor: (@flag, @value) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/me/flags"))
    .withCredentials()
    .send {@flag, @value}

  onSuccess: (result, publish) ->
    user = new User(result.user)
    publish new UserChangedEvent(user)

module.exports = SetMyFlagRequest
