Event = require 'framework/Event'

class CardChangedEvent extends Event

  constructor: (@card) ->
    super()

module.exports = CardChangedEvent
