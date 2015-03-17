DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class ChecklistChangedEvent extends DocumentChangedEvent

  type: 'ChecklistChanged'

  constructor: (@checklist, origin) ->
    super(origin)

module.exports = ChecklistChangedEvent
