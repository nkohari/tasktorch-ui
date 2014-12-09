superagent        = require 'superagent'
Request           = require 'framework/Request'
StacksLoadedEvent = require 'events/StacksLoadedEvent'

class LoadMyStacksRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/me/stacks", (res) =>
      {stacks} = res.body
      eventBus.publish new StacksLoadedEvent(stacks)

module.exports = LoadMyStacksRequest
