Request = require 'data/framework/Request'

class JoinUserChannelRequest extends Request

  constructor: (@userid) ->

  create: (agent) ->
    eventQueue.subscribe("private-user-#{@userid}")

module.exports = JoinUserChannelRequest
