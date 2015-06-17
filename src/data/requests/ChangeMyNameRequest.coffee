superagent       = require 'superagent'
User             = require 'data/models/User'
UserChangedEvent = require 'events/change/UserChangedEvent'
Request          = require 'data/framework/Request'

class ChangeMyNameRequest extends Request

  constructor: (@name) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/me/name"))
    .withCredentials()
    .send {@name}
    .end (err, res) =>
      card = new User(res.body.user)
      eventQueue.publish new UserChangedEvent(user)

module.exports = ChangeMyNameRequest
