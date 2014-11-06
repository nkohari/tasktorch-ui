Event = require 'framework/Event'

class TeamsLoadedEvent extends Event

  constructor: (@teams) ->
    super()

module.exports = TeamsLoadedEvent
