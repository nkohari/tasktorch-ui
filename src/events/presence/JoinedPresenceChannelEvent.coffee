Event = require 'events/framework/Event'

class JoinedPresenceChannelEvent extends Event
  
  type: 'JoinedPresenceChannel'

  constructor: (@onlineUsers) ->
    super()

module.exports = JoinedPresenceChannelEvent
