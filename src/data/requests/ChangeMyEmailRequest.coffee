superagent       = require 'superagent'
User             = require 'data/models/User'
UserChangedEvent = require 'events/change/UserChangedEvent'
Request          = require 'data/framework/Request'

class ChangeMyEmailRequest extends Request

  constructor: (@email) ->

  execute: (eventQueue) ->
    superagent.post("/api/me/email")
    .send {@email}
    .end (res) =>
      card = new User(res.body.user)
      eventQueue.publish new UserChangedEvent(user)

module.exports = ChangeMyEmailRequest
