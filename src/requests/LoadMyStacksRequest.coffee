superagent        = require 'superagent'
Request           = require 'framework/Request'
StacksLoadedEvent = require 'events/StacksLoadedEvent'

class LoadMyQueueRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/me/stacks", (res) =>
      eventBus.publish new StacksLoadedEvent(res.body)

module.exports = LoadMyQueueRequest
