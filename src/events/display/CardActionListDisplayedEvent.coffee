Event = require 'framework/Event'

class CardActionListDisplayedEvent extends Event

  constructor: (@cardId, @actionIds) ->
    super()

module.exports = CardActionListDisplayedEvent
