Event = require 'framework/Event'

class CardListDisplayedEvent extends Event

  type: 'CardListDisplayed'

  constructor: (@stackid, @cardids) ->
    super()

module.exports = CardListDisplayedEvent
