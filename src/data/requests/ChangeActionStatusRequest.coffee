superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class ChangeActionStatusRequest extends Request

  constructor: (@actionid, @status) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/actions/#{@actionid}/status"))
    .withCredentials()
    .send {@status}
    .end (err, res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionChangedEvent(action)

module.exports = ChangeActionStatusRequest
