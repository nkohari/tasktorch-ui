Event = require 'framework/Event'

class NoteCreatedEvent extends Event

  constructor: (@note) ->
    super()

module.exports = NoteCreatedEvent
