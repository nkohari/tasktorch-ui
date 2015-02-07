Event = require 'framework/Event'

class StackDisplayedEvent extends Event

  type: 'StackDisplayed'

  constructor: (@stackid) ->
    super()

module.exports = StackDisplayedEvent
