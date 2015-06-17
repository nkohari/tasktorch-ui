superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class ChangeActionTextRequest extends Request

  constructor: (@actionid, @text) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/actions/#{@actionid}/text"))
    .withCredentials()
    .send {@text}
    .end (err, res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionChangedEvent(action)

module.exports = ChangeActionTextRequest
