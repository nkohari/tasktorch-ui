superagent        = require 'superagent'
Stack             = require 'data/models/Stack'
Request           = require 'data/framework/Request'
StackChangedEvent = require 'events/change/StackChangedEvent'

class RenameStackRequest extends Request

  constructor: (@stackid, @name) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/stacks/#{@stackid}/name")
    .send {@name}
    .end (res) =>
      stack = new Stack(res.body.stack)
      eventQueue.publish new StackChangedEvent(stack)

module.exports = RenameStackRequest
