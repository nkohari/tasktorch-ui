superagent         = require 'superagent'
Request            = require 'framework/Request'
ActionChangedEvent = require 'events/change/ActionChangedEvent'

class MoveActionRequest extends Request

  constructor: (@action, @cardId, @stageId, @position) ->

  execute: ->
    superagent.post("/api/#{@action.org}/actions/#{@action.id}/move")
    .send {card: @cardId, stage: @stageId, @position}
    .end (res) =>
      {action} = res.body
      eventBus.publish new ActionChangedEvent(action)

module.exports = MoveActionRequest
