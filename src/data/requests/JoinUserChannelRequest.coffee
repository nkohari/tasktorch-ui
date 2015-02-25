Request = require 'data/framework/Request'

class JoinUserChannelRequest extends Request

  constructor: (@userid) ->

  execute: (eventQueue) ->
    eventQueue.subscribe("private-user-#{@userid}")

module.exports = JoinUserChannelRequest
