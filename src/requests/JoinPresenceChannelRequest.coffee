Request                = require 'framework/Request'
CurrentUserLoadedEvent = require 'events/CurrentUserLoadedEvent'

class JoinPresenceChannelRequest extends Request

  execute: (context, eventBus) ->
    eventBus.subscribe("presence-#{context.organizationId}")

module.exports = JoinPresenceChannelRequest
