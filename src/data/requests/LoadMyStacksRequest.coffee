_                   = require 'lodash'
superagent          = require 'superagent'
Stack               = require 'data/models/Stack'
StacksLoadedEvent   = require 'events/load/StacksLoadedEvent'
MyStacksLoadedEvent = require 'events/load/MyStacksLoadedEvent'
Request             = require 'data/framework/Request'

class LoadMyStacksRequest extends Request

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/me/stacks"))
    .withCredentials()
    .end (err, res) =>
      stacks = _.map res.body.stacks, (doc) -> new Stack(doc)
      eventQueue.publish new StacksLoadedEvent(stacks)
      eventQueue.publish new MyStacksLoadedEvent(stacks)

module.exports = LoadMyStacksRequest
