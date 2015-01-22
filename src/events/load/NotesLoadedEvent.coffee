Event = require 'framework/Event'
Note  = require 'models/Note'

class NotesLoadedEvent extends Event

  constructor: (docs) ->
    super()
    @notes = @createModels(Note, docs)

module.exports = NotesLoadedEvent
