Event = require 'framework/Event'

class QueueLoadedEvent extends Event
  
  type: 'QueueLoaded'

  constructor: (@queue, @cards) ->
    super()

module.exports = QueueLoadedEvent
