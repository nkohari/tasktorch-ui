DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class ActionChangedEvent extends DocumentChangedEvent

  type: 'ActionChanged'

  constructor: (@action, origin) ->
    super(origin)

module.exports = ActionChangedEvent
