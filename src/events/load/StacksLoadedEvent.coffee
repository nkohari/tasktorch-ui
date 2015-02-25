Event = require 'events/framework/Event'

class StacksLoadedEvent extends Event

  type: 'StacksLoaded'

  constructor: (@stacks) ->

module.exports = StacksLoadedEvent
