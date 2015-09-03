DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class NotesLoadedEvent extends DataLoadedEvent

  type: 'NotesLoaded'

  constructor: (@notes) ->

module.exports = NotesLoadedEvent
