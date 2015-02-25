DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class StackDeletedEvent extends DocumentDeletedEvent

  type: 'StackDeleted'

  constructor: (@stack, origin) ->
    super(origin)

module.exports = StackDeletedEvent
