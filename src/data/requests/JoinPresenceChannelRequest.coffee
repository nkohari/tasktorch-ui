Request = require 'data/framework/Request'

class JoinPresenceChannelRequest extends Request

  constructor: (@orgid) ->

  create: (agent) ->
    eventQueue.subscribe("presence-org-#{@orgid}")

module.exports = JoinPresenceChannelRequest
