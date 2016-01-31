DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class FileCreatedEvent extends DocumentCreatedEvent

  type: 'FileCreated'

  constructor: (@file, origin) ->
    super(origin)

module.exports = FileCreatedEvent
