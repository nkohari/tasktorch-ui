Event = require '../../framework/Event'

class StacksLoadedEvent extends Event

  constructor: (@cards) ->
    super()

module.exports = StacksLoadedEvent
