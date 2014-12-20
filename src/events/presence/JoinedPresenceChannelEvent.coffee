Event = require 'framework/Event'

class JoinedPresenceChannelEvent extends Event

  constructor: (@connectedUsers) ->
    super()

module.exports = JoinedPresenceChannelEvent
