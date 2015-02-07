Event = require 'framework/Event'

class CardDisplayedEvent extends Event

  type: 'CardDisplayed'

  constructor: (@cardid) ->
    super()

module.exports = CardDisplayedEvent
