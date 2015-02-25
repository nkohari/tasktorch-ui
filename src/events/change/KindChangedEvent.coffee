DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class KindChangedEvent extends DocumentChangedEvent

  type: 'KindChanged'

  constructor: (@kind, origin) ->
    super(origin)

module.exports = KindChangedEvent
