Stack             = require 'data/models/Stack'
StackCreatedEvent = require 'events/create/StackCreatedEvent'
Request           = require 'data/framework/Request'

class CreateUserStackRequest extends Request

  constructor: (@name) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/me/stacks"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    stack = new Stack(result.stack)
    publish new StackCreatedEvent(stack)

module.exports = CreateUserStackRequest
