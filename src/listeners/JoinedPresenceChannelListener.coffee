_ = require 'lodash'
Listener = require 'framework/Listener'
JoinedPresenceChannelEvent = require 'events/JoinedPresenceChannelEvent'

class JoinedPresenceChannelListener extends Listener

  listensFor: 'pusher:subscription_succeeded'

  createEvent: (message) ->
    connectedUsers = _.map message.members, (member) -> member
    new JoinedPresenceChannelEvent(connectedUsers)

module.exports = JoinedPresenceChannelListener
