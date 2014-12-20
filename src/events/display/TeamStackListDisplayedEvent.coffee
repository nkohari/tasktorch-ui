Event = require 'framework/Event'

class TeamStackListDisplayedEvent extends Event

  constructor: (@teamId, @stackIds) ->
    super()

module.exports = TeamStackListDisplayedEvent
