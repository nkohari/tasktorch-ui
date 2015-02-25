EventHandler = require 'events/framework/EventHandler'

class Channel extends EventHandler

  constructor: (eventQueue, @messageBus) ->
    super(eventQueue)

  publish: (event) ->
    @eventQueue.publish(event)

module.exports = Channel
