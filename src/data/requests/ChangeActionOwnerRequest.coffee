superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class ChangeActionOwnerRequest extends Request

  constructor: (@actionid, @userid) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/actions/#{@actionid}/user")
    .send {user: @userid}
    .end (res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionChangedEvent(action)

module.exports = ChangeActionOwnerRequest
