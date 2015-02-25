DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class StackCreatedEvent extends DocumentCreatedEvent

  type: 'StackCreated'

  constructor: (@stack, origin) ->
    super(origin)

module.exports = StackCreatedEvent
