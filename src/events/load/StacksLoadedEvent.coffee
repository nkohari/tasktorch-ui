Event = require 'framework/Event'

class StacksLoadedEvent extends Event

  type: 'StacksLoaded'

  constructor: (@stacks) ->
    super()

module.exports = StacksLoadedEvent
