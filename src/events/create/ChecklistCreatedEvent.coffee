DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class ChecklistCreatedEvent extends DocumentCreatedEvent

  type: 'ChecklistCreated'

  constructor: (@checklist, origin) ->
    super(origin)

module.exports = ChecklistCreatedEvent
