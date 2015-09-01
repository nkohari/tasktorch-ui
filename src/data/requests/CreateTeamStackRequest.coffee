Stack             = require 'data/models/Stack'
StackCreatedEvent = require 'events/create/StackCreatedEvent'
Request           = require 'data/framework/Request'

class CreateTeamStackRequest extends Request

  constructor: (@teamid, @name) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/stacks"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    stack = new Stack(result.stack)
    publish new StackCreatedEvent(stack)

module.exports = CreateTeamStackRequest
