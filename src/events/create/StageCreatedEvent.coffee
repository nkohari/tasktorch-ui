DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class StageCreatedEvent extends DocumentCreatedEvent

  type: 'StageCreated'

  constructor: (@stage, origin) ->
    super(origin)

module.exports = StageCreatedEvent
