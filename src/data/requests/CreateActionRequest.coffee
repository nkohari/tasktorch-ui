superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionCreatedEvent = require 'events/create/ActionCreatedEvent'
Request            = require 'data/framework/Request'

class CreateActionRequest extends Request

  constructor: (@checklistid, @text) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/checklists/#{@checklistid}/actions")
    .send({@text})
    .end (res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionCreatedEvent(action)

module.exports = CreateActionRequest
