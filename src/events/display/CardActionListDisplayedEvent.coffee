Event = require 'framework/Event'

class CardActionListDisplayedEvent extends Event

  type: 'CardActionListDisplayed'

  constructor: (@cardid, @actionids) ->
    super()

module.exports = CardActionListDisplayedEvent
