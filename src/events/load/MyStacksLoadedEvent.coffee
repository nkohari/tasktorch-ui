DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class MyStacksLoadedEvent extends DataLoadedEvent

  type: 'MyStacksLoaded'

  constructor: (@stacks) ->

module.exports = MyStacksLoadedEvent
