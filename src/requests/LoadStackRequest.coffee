superagent        = require 'superagent'
Request           = require 'framework/Request'
StacksLoadedEvent = require 'events/load/StacksLoadedEvent'

class LoadStackRequest extends Request

  constructor: (@stackId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgId}/stacks/#{@stackId}", (res) =>
      {stack} = res.body
      eventBus.publish new StacksLoadedEvent([stack])

module.exports = LoadStackRequest
