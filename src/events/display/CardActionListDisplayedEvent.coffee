Event = require 'framework/Event'

class CardActionListDisplayedEvent extends Event

  type: 'CardActionListDisplayed'

  constructor: (@cardId, @actionIds) ->
    super()

module.exports = CardActionListDisplayedEvent
