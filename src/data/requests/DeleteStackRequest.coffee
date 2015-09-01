Stack             = require 'data/models/Stack'
StackDeletedEvent = require 'events/delete/StackDeletedEvent'
Request           = require 'data/framework/Request'

class DeleteStackRequest extends Request

  constructor: (@stackid) ->

  create: (agent) ->
    agent
    .del(@urlFor("/#{Environment.orgid}/stacks/#{@stackid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    stack = new Stack(result.stack)
    publish new StackDeletedEvent(stack)

module.exports = DeleteStackRequest
