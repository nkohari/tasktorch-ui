Request = require 'data/framework/Request'

class JoinPresenceChannelRequest extends Request

  constructor: (@orgid) ->

  execute: (eventQueue) ->
    eventQueue.subscribe("presence-org-#{@orgid}")

module.exports = JoinPresenceChannelRequest
