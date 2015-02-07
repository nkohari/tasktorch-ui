superagent         = require 'superagent'
Request            = require 'framework/Request'
ActionChangedEvent = require 'events/change/ActionChangedEvent'

class ChangeActionOwnerRequest extends Request

  constructor: (@action, @userid) ->

  execute: ->
    superagent.post("/api/#{@action.org}/actions/#{@action.id}/owner")
    .send {user: @userid}
    .end (res) =>
      {action} = res.body
      eventBus.publish new ActionChangedEvent(action)

module.exports = ChangeActionOwnerRequest
