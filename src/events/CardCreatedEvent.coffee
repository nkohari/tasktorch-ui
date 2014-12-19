Event = require 'framework/Event'

class CardCreatedEvent extends Event

  constructor: (@card) ->
    super()

module.exports = CardCreatedEvent
