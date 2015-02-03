Event = require 'framework/Event'

class TeamStackListDisplayedEvent extends Event

  type: 'TeamStackListDisplayed'

  constructor: (@teamId, @stackIds) ->
    super()

module.exports = TeamStackListDisplayedEvent
