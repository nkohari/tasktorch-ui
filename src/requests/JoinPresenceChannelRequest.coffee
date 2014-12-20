Request = require 'framework/Request'

class JoinPresenceChannelRequest extends Request

  execute: (context, eventBus) ->
    eventBus.subscribe("presence-#{context.organizationId}")

module.exports = JoinPresenceChannelRequest
