Event = require 'framework/Event'

class CardHandedOffEvent extends Event

  constructor: (@card, @oldStack, @newStack, meta) ->
    super(meta)

module.exports = CardHandedOffEvent
