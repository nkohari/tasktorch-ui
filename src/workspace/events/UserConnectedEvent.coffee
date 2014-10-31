Event = require '../../framework/Event'

class UserConnectedEvent extends Event

  constructor: (@user) ->
    super()

module.exports = UserConnectedEvent
