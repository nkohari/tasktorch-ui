DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class CardDeletedEvent extends DocumentDeletedEvent

  type: 'CardDeleted'

  constructor: (@card, origin) ->
    super(origin)

module.exports = CardDeletedEvent
