superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class ChangeActionStatusRequest extends Request

  constructor: (@actionid, @status) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/actions/#{@actionid}/status")
    .send {@status}
    .end (res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionChangedEvent(action)

module.exports = ChangeActionStatusRequest
