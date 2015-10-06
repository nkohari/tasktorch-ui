Stack             = require 'data/models/Stack'
StackDeletedEvent = require 'events/delete/StackDeletedEvent'
Request           = require 'data/framework/Request'

class DeleteStackRequest extends Request

  constructor: (@stackid) ->

  create: (identity, agent) ->
    agent
    .del(@urlFor("/#{identity.orgid}/stacks/#{@stackid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    stack = new Stack(result.stack)
    publish new StackDeletedEvent(stack)

module.exports = DeleteStackRequest
