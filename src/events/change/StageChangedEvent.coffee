DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class StageChangedEvent extends DocumentChangedEvent

  type: 'StageChanged'

  constructor: (@stage, origin) ->
    super(origin)

module.exports = StageChangedEvent
