Event = require 'framework/Event'

class CardListDisplayedEvent extends Event

  type: 'CardListDisplayed'

  constructor: (@stackId, @cardIds) ->
    super()

module.exports = CardListDisplayedEvent
