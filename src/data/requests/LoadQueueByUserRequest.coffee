_                 = require 'lodash'
superagent        = require 'superagent'
Request           = require 'data/framework/Request'
Stack             = require 'data/models/Stack'
StacksLoadedEvent = require 'events/load/StacksLoadedEvent'

class LoadQueueByUserRequest extends Request

  constructor: (@userid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/members/#{@userid}/queue", (res) =>
      stack = new Stack(res.body.stack)
      eventQueue.publish new StacksLoadedEvent([stack])

module.exports = LoadQueueByUserRequest
