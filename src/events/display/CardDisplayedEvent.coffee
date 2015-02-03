Event = require 'framework/Event'

class CardDisplayedEvent extends Event

  type: 'CardDisplayed'

  constructor: (@cardId) ->
    super()

module.exports = CardDisplayedEvent
