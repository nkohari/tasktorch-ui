superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class ChangeActionTextRequest extends Request

  constructor: (@actionid, @text) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/actions/#{@action.id}/text")
    .send {@text}
    .end (res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionChangedEvent(action)

module.exports = ChangeActionTextRequest
