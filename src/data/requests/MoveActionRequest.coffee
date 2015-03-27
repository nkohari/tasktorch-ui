superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class MoveActionRequest extends Request

  constructor: (@actionid, @checklistid, @position) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/actions/#{@actionid}/move")
    .send {checklist: @checklistid, @position}
    .end (res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionChangedEvent(action)

module.exports = MoveActionRequest
