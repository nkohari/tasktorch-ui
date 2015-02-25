superagent        = require 'superagent'
Stack             = require 'data/models/Stack'
StacksLoadedEvent = require 'events/load/StacksLoadedEvent'
Request           = require 'data/framework/Request'

class LoadStackRequest extends Request

  constructor: (@stackid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/stacks/#{@stackid}", (res) =>
      stack = new Stack(res.body.stack)
      eventQueue.publish new StacksLoadedEvent([stack])

module.exports = LoadStackRequest
