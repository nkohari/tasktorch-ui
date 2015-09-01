Stack             = require 'data/models/Stack'
Request           = require 'data/framework/Request'
StackChangedEvent = require 'events/change/StackChangedEvent'

class RenameStackRequest extends Request

  constructor: (@stackid, @name) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/stacks/#{@stackid}/name"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    stack = new Stack(result.stack)
    publish new StackChangedEvent(stack)

module.exports = RenameStackRequest
