Event = require 'framework/Event'

class CardDisplayedEvent extends Event

  constructor: (@cardId) ->
    super()

module.exports = CardDisplayedEvent
