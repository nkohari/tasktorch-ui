DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class NoteChangedEvent extends DocumentChangedEvent

  type: 'NoteChanged'

  constructor: (@note, origin) ->
    super(origin)

module.exports = NoteChangedEvent
