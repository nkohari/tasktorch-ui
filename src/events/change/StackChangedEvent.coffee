DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class StackChangedEvent extends DocumentChangedEvent

  type: 'StackChanged'

  constructor: (@stack, origin) ->
    super(origin)

module.exports = StackChangedEvent
