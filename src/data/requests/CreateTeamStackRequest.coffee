superagent        = require 'superagent'
Stack             = require 'data/models/Stack'
StackCreatedEvent = require 'events/create/StackCreatedEvent'
Request           = require 'data/framework/Request'

class CreateTeamStackRequest extends Request

  constructor: (@teamid, @name) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/teams/#{@teamid}/stacks")
    .send({@name})
    .end (res) =>
      stack = new Stack(res.body.stack)
      eventQueue.publish new StackCreatedEvent(stack)

module.exports = CreateTeamStackRequest
