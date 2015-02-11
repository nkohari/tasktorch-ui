Event = require 'framework/Event'
Note  = require 'data/models/Note'

class NotesLoadedEvent extends Event

  type: 'NotesLoaded'

  constructor: (docs) ->
    super()
    @notes = @createModels(Note, docs)

module.exports = NotesLoadedEvent
