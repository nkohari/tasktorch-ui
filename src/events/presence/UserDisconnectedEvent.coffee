Event = require 'framework/Event'

class UserDisconnectedEvent extends Event

  type: 'UserDisconnected'

  constructor: (@user) ->
    super()

module.exports = UserDisconnectedEvent
