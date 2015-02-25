superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionCreatedEvent = require 'events/create/ActionCreatedEvent'
Request            = require 'data/framework/Request'

class CreateActionRequest extends Request

  constructor: (@cardid, @stageid, @text) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/cards/#{@cardid}/actions")
    .send({stage: @stageid, text: @text})
    .end (res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionCreatedEvent(action)

module.exports = CreateActionRequest
