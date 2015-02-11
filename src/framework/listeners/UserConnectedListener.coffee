Listener           = require 'framework/Listener'
UserConnectedEvent = require 'events/presence/UserConnectedEvent'

class UserConnectedListener extends Listener

  listensFor: 'pusher:member_added'

  createEvent: (message) ->
    new UserConnectedEvent(message.info)

module.exports = UserConnectedListener
