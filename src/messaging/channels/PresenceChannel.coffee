_                          = require 'lodash'
Channel                    = require 'messaging/framework/Channel'
JoinedPresenceChannelEvent = require 'events/presence/JoinedPresenceChannelEvent'
UserConnectedEvent         = require 'events/presence/UserConnectedEvent'
UserDisconnectedEvent      = require 'events/presence/UserDisconnectedEvent'

class PresenceChannel extends Channel

  displayName: 'PresenceChannel'

  listensFor: [
    'UserSelectedOrg'
  ]

  onUserSelectedOrg: (event) ->
    channel = @messageBus.subscribe("presence-org-#{event.orgid}")
    channel.bind('pusher:subscription_succeeded', @onSubscriptionSucceeded, this)
    channel.bind('pusher:member_added', @onUserConnected, this)
    channel.bind('pusher:member_removed', @onUserDisconnected, this)

  onSubscriptionSucceeded: (message) ->
    connectedUsers = _.map message.members, (member) -> member
    @publish new JoinedPresenceChannelEvent(connectedUsers)

  onUserConnected: (message) ->
    @publish new UserConnectedEvent(message.info)

  onUserDisconnected: (message) ->
    @publish new UserDisconnectedEvent(message.info)

module.exports = PresenceChannel
