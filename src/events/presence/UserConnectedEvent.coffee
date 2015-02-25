Event = require 'events/framework/Event'

class UserConnectedEvent extends Event

  type: 'UserConnected'

  constructor: (@user) ->
    super()

module.exports = UserConnectedEvent
