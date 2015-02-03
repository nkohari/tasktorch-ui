Event = require 'framework/Event'

class CardChangedEvent extends Event

  type: 'CardChanged'

  constructor: (@card) ->
    super()

module.exports = CardChangedEvent
