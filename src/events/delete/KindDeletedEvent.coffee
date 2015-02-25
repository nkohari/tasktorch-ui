DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class KindDeletedEvent extends DocumentDeletedEvent

  type: 'KindDeleted'

  constructor: (@kind, origin) ->
    super(origin)

module.exports = KindDeletedEvent
