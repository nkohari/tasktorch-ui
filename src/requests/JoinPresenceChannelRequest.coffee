Request = require 'framework/Request'

class JoinPresenceChannelRequest extends Request

  execute: (context, eventBus) ->
    eventBus.subscribe("presence-org-#{context.orgId}")

module.exports = JoinPresenceChannelRequest
