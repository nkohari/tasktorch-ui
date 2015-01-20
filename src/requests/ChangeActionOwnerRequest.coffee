superagent         = require 'superagent'
Request            = require 'framework/Request'
ActionChangedEvent = require 'events/change/ActionChangedEvent'

class ChangeActionOwnerRequest extends Request

  constructor: (@action, @userId) ->

  execute: ->
    superagent.post("/api/#{@action.organization}/actions/#{@action.id}/owner")
    .send {user: @userId}
    .end (res) =>
      {action} = res.body
      eventBus.publish new ActionChangedEvent(action)

module.exports = ChangeActionOwnerRequest
