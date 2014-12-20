Listener              = require 'framework/Listener'
UserDisconnectedEvent = require 'events/presence/UserDisconnectedEvent'

class UserDisconnectedListener extends Listener

  listensFor: 'pusher:member_removed'

  createEvent: (message) ->
    new UserDisconnectedEvent(message.info)

module.exports = UserDisconnectedListener
