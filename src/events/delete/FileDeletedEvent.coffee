DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class FileDeletedEvent extends DocumentDeletedEvent

  type: 'FileDeleted'

  constructor: (@file, origin) ->
    super(origin)

module.exports = FileDeletedEvent
