Event = require 'framework/Event'

class ActionsLoadedEvent extends Event

  type: 'ActionsLoaded'

  constructor: (@actions) ->
    super()

module.exports = ActionsLoadedEvent
