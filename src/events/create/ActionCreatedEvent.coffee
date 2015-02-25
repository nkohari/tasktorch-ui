DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class ActionCreatedEvent extends DocumentCreatedEvent

  type: 'ActionCreated'

  constructor: (@action, origin) ->
    super(origin)

module.exports = ActionCreatedEvent
