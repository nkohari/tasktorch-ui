superagent         = require 'superagent'
Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class MoveActionRequest extends Request

  constructor: (@action, @cardid, @stageid, @position) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{@action.org}/actions/#{@action.id}/move")
    .send {card: @cardid, stage: @stageid, @position}
    .end (res) =>
      action = new Action(res.body.action)
      eventQueue.publish new ActionChangedEvent(action)

module.exports = MoveActionRequest
