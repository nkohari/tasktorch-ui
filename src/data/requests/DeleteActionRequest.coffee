superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionDeletedEvent = require 'events/delete/ActionDeletedEvent'
Request            = require 'data/framework/Request'

class DeleteActionRequest extends Request

  constructor: (@actionid) ->

  execute: (eventQueue) ->
    superagent.del("/api/#{Environment.orgid}/actions/#{@actionid}")
    .end (res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionDeletedEvent(action)

module.exports = DeleteActionRequest
