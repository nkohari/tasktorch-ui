superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionDeletedEvent = require 'events/delete/ActionDeletedEvent'
Request            = require 'data/framework/Request'

class DeleteActionRequest extends Request

  constructor: (@actionid) ->

  execute: (eventQueue) ->
    superagent.del(@urlFor("/#{Environment.orgid}/actions/#{@actionid}"))
    .withCredentials()
    .end (err, res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionDeletedEvent(action)

module.exports = DeleteActionRequest
