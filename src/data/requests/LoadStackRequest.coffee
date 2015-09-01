Stack             = require 'data/models/Stack'
StacksLoadedEvent = require 'events/load/StacksLoadedEvent'
Request           = require 'data/framework/Request'

class LoadStackRequest extends Request

  constructor: (@stackid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/stacks/#{@stackid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    stack = new Stack(result.stack)
    publish new StacksLoadedEvent([stack])

module.exports = LoadStackRequest
