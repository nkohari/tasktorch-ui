Event = require 'framework/Event'

class StackChangedEvent extends Event

  constructor: (@stack) ->
    super()

module.exports = StackChangedEvent
