Event = require '../../framework/Event'

class FocusLoadedEvent extends Event

  constructor: (@card) ->
    super()

module.exports = FocusLoadedEvent
