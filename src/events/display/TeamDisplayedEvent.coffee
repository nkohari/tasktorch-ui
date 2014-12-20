Event = require 'framework/Event'

class TeamDisplayedEvent extends Event

  constructor: (@teamId) ->
    super()

module.exports = TeamDisplayedEvent
