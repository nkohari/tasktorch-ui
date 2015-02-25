Event = require 'events/framework/Event'

class MyStacksLoadedEvent extends Event

  type: 'MyStacksLoaded'

  constructor: (@stacks) ->

module.exports = MyStacksLoadedEvent
