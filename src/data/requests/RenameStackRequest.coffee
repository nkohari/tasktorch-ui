superagent        = require 'superagent'
Stack             = require 'data/models/Stack'
Request           = require 'data/framework/Request'
StackChangedEvent = require 'events/change/StackChangedEvent'

class RenameStackRequest extends Request

  constructor: (@stackid, @name) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/stacks/#{@stackid}/name"))
    .withCredentials()
    .send {@name}
    .end (err, res) =>
      stack = new Stack(res.body.stack)
      eventQueue.publish new StackChangedEvent(stack)

module.exports = RenameStackRequest
