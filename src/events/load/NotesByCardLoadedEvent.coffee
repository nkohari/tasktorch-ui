Event = require 'events/framework/Event'

class NotesByCardLoadedEvent extends Event

  type: 'NotesByCardLoaded'

  constructor: (@cardid, @notes) ->

module.exports = NotesByCardLoadedEvent
