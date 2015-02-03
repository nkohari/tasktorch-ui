Event = require 'framework/Event'

class StackChangedEvent extends Event

  type: 'StackChanged'

  constructor: (@stack) ->
    super()

module.exports = StackChangedEvent
