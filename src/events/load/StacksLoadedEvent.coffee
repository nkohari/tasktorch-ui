Event = require 'framework/Event'

class StacksLoadedEvent extends Event

  constructor: (@stacks) ->
    super()

module.exports = StacksLoadedEvent
