DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class CardCreatedEvent extends DocumentCreatedEvent

  type: 'CardCreated'

  constructor: (@card, origin) ->
    super(origin)

module.exports = CardCreatedEvent
