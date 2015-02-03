Event = require 'framework/Event'

class ActionCreatedEvent extends Event

  type: 'ActionCreated'

  constructor: (@action) ->
    super()

module.exports = ActionCreatedEvent
