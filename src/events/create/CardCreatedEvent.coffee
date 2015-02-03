Event = require 'framework/Event'

class CardCreatedEvent extends Event

  type: 'CardCreated'

  constructor: (@card) ->
    super()

module.exports = CardCreatedEvent
