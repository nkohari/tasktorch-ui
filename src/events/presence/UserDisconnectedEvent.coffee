Event = require 'framework/Event'

class UserDisconnectedEvent extends Event

  constructor: (@user) ->
    super()

module.exports = UserDisconnectedEvent
