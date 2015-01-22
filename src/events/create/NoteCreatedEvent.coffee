Event = require 'framework/Event'
Note  = require 'models/Note'

class NoteCreatedEvent extends Event

  constructor: (doc) ->
    super()
    @note = new Note(doc)

module.exports = NoteCreatedEvent
