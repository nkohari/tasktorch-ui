Event = require 'events/framework/Event'

class JoinedPresenceChannelEvent extends Event
  
  type: 'JoinedPresenceChannel'

  constructor: (@connectedUsers) ->
    super()

module.exports = JoinedPresenceChannelEvent
