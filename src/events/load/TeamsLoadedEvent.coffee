Event = require 'framework/Event'

class TeamsLoadedEvent extends Event

  type: 'TeamsLoaded'

  constructor: (@teams) ->
    super()

module.exports = TeamsLoadedEvent
