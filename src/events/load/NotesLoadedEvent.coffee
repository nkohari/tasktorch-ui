Event = require 'events/framework/Event'

class NotesLoadedEvent extends Event

  type: 'NotesLoaded'

  constructor: (@notes) ->

module.exports = NotesLoadedEvent
