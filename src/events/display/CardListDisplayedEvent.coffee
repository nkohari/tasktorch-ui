Event = require 'framework/Event'

class CardListDisplayedEvent extends Event

  constructor: (@stackId, @cardIds) ->
    super()

module.exports = CardListDisplayedEvent
