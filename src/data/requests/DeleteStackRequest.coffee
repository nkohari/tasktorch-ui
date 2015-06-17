superagent        = require 'superagent'
Stack             = require 'data/models/Stack'
StackDeletedEvent = require 'events/delete/StackDeletedEvent'
Request           = require 'data/framework/Request'

class DeleteStackRequest extends Request

  constructor: (@stackid) ->

  execute: (eventQueue) ->
    superagent.del(@urlFor("/#{Environment.orgid}/stacks/#{@stackid}"))
    .withCredentials()
    .end (err, res) =>
      stack = new Stack(res.body.stack)
      eventQueue.publish new StackDeletedEvent(stack)

module.exports = DeleteStackRequest
