DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class ActionDeletedEvent extends DocumentDeletedEvent

  type: 'ActionDeleted'

  constructor: (@action, origin) ->
    super(origin)

module.exports = ActionDeletedEvent
