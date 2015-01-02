Event = require 'framework/Event'

class NotesLoadedEvent extends Event

  constructor: (@notes) ->
    super()

module.exports = NotesLoadedEvent
