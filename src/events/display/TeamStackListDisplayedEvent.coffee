Event = require 'framework/Event'

class TeamStackListDisplayedEvent extends Event

  type: 'TeamStackListDisplayed'

  constructor: (@teamid, @stackids) ->
    super()

module.exports = TeamStackListDisplayedEvent
