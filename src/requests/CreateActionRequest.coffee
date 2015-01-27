_                  = require 'lodash'
superagent         = require 'superagent'
Header             = require 'framework/enums/Header'
Request            = require 'framework/Request'
ActionCreatedEvent = require 'events/create/ActionCreatedEvent'

class CreateActionRequest extends Request

  constructor: (@card, @stage) ->

  execute: (context, eventBus, callback) ->
    superagent.post("/api/#{@card.org}/cards/#{@card.id}/actions")
    .set(Header.Socket, eventBus.getSocketId())
    .send({stage: @stage.id})
    .end (res) =>
      {action} = res.body
      eventBus.publish new ActionCreatedEvent(action)
      callback(null, action)

module.exports = CreateActionRequest
