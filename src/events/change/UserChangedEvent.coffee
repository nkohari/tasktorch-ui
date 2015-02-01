Event = require 'framework/Event'

class UserChangedEvent extends Event

  constructor: (@user) ->
    super()

module.exports = UserChangedEvent
