Event = require 'framework/Event'

class ActionCreatedEvent extends Event

  constructor: (@action) ->
    super()

module.exports = ActionCreatedEvent
