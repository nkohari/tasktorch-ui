DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class NotesByCardLoadedEvent extends DataLoadedEvent

  type: 'NotesByCardLoaded'

  constructor: (@cardid, @notes) ->

module.exports = NotesByCardLoadedEvent
