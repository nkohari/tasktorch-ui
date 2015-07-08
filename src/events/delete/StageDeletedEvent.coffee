DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class StageDeletedEvent extends DocumentDeletedEvent

  type: 'StageDeleted'

  constructor: (@stage, origin) ->
    super(origin)

module.exports = StageDeletedEvent
