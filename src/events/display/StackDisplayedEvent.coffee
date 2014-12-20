Event = require 'framework/Event'

class StackDisplayedEvent extends Event

  constructor: (@stackId) ->
    super()

module.exports = StackDisplayedEvent
