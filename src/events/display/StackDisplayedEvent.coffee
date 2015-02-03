Event = require 'framework/Event'

class StackDisplayedEvent extends Event

  type: 'StackDisplayed'

  constructor: (@stackId) ->
    super()

module.exports = StackDisplayedEvent
