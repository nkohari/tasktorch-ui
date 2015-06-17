superagent        = require 'superagent'
Stack             = require 'data/models/Stack'
StackCreatedEvent = require 'events/create/StackCreatedEvent'
Request           = require 'data/framework/Request'

class CreateTeamStackRequest extends Request

  constructor: (@teamid, @name) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/stacks"))
    .withCredentials()
    .send({@name})
    .end (err, res) =>
      stack = new Stack(res.body.stack)
      eventQueue.publish new StackCreatedEvent(stack)

module.exports = CreateTeamStackRequest
