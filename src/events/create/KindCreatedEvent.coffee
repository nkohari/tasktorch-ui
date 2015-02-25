DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class KindCreatedEvent extends DocumentCreatedEvent

  type: 'KindCreated'

  constructor: (@kind, origin) ->
    super(origin)

module.exports = KindCreatedEvent
