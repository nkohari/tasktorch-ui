Event = require 'framework/Event'

class CardNoteListDisplayedEvent extends Event

  type: 'CardNoteListDisplayed'

  constructor: (@cardid) ->
    super()

module.exports = CardNoteListDisplayedEvent
