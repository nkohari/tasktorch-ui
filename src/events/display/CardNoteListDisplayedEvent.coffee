Event = require 'framework/Event'

class CardNoteListDisplayedEvent extends Event

  constructor: (@cardId) ->
    super()

module.exports = CardNoteListDisplayedEvent
