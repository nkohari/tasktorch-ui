DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class StacksLoadedEvent extends DataLoadedEvent

  type: 'StacksLoaded'

  constructor: (@stacks) ->

module.exports = StacksLoadedEvent
