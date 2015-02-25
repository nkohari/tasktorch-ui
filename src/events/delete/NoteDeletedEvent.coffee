DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class NoteDeletedEvent extends DocumentDeletedEvent

  type: 'NoteDeleted'

  constructor: (@note, origin) ->
    super(origin)

module.exports = NoteDeletedEvent
