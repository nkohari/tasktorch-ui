DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class CardChangedEvent extends DocumentChangedEvent

  type: 'CardChanged'

  constructor: (@card, origin) ->
    super(origin)

module.exports = CardChangedEvent
