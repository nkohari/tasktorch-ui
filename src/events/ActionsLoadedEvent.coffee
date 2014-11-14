Event = require 'framework/Event'

class ActionsLoadedEvent extends Event

  constructor: (@actions) ->
    super()

module.exports = ActionsLoadedEvent
