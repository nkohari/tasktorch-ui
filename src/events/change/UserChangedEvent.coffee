Event = require 'framework/Event'

class UserChangedEvent extends Event

  team: 'UserChanged'

  constructor: (@user) ->
    super()

module.exports = UserChangedEvent
