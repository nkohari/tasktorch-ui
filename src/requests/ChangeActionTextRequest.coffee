superagent         = require 'superagent'
Request            = require 'framework/Request'
ActionChangedEvent = require 'events/change/ActionChangedEvent'

class ChangeActionTextRequest extends Request

  constructor: (@action, @text) ->

  execute: ->
    superagent.post("/api/#{@action.organization}/actions/#{@action.id}/text")
    .send {@text}
    .end (res) =>
      {action} = res.body
      eventBus.publish new ActionChangedEvent(action)

module.exports = ChangeActionTextRequest
