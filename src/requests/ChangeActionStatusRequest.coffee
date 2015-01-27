superagent         = require 'superagent'
Request            = require 'framework/Request'
ActionChangedEvent = require 'events/change/ActionChangedEvent'

class ChangeActionStatusRequest extends Request

  constructor: (@action, @status) ->

  execute: ->
    superagent.post("/api/#{@action.org}/actions/#{@action.id}/status")
    .send {@status}
    .end (res) =>
      {action} = res.body
      eventBus.publish new ActionChangedEvent(action)

module.exports = ChangeActionStatusRequest
