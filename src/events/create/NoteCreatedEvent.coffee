Event = require 'framework/Event'
Note  = require 'data/models/Note'

class NoteCreatedEvent extends Event

  type: 'NoteCreated'

  constructor: (doc) ->
    super()
    @note = new Note(doc)

module.exports = NoteCreatedEvent
