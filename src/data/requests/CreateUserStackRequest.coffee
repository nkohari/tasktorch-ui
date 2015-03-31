superagent        = require 'superagent'
Stack             = require 'data/models/Stack'
StackCreatedEvent = require 'events/create/StackCreatedEvent'
Request           = require 'data/framework/Request'

class CreateUserStackRequest extends Request

  constructor: (@name) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/me/stacks")
    .send({@name})
    .end (res) =>
      stack = new Stack(res.body.stack)
      eventQueue.publish new StackCreatedEvent(stack)

module.exports = CreateUserStackRequest
