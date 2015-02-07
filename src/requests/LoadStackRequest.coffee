superagent        = require 'superagent'
Request           = require 'framework/Request'
StacksLoadedEvent = require 'events/load/StacksLoadedEvent'

class LoadStackRequest extends Request

  constructor: (@stackid) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/stacks/#{@stackid}", (res) =>
      {stack} = res.body
      eventBus.publish new StacksLoadedEvent([stack])

module.exports = LoadStackRequest
