DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class NoteCreatedEvent extends DocumentCreatedEvent

  type: 'NoteCreated'

  constructor: (@note, origin) ->
    super(origin)

module.exports = NoteCreatedEvent
