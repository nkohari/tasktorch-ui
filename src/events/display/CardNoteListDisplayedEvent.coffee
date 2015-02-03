Event = require 'framework/Event'

class CardNoteListDisplayedEvent extends Event

  type: 'CardNoteListDisplayed'

  constructor: (@cardId) ->
    super()

module.exports = CardNoteListDisplayedEvent
