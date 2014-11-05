Event = require '../../framework/Event'

class QueueLoadedEvent extends Event

  constructor: (@queue, @cards) ->
    super()

module.exports = QueueLoadedEvent
