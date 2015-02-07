Event = require 'framework/Event'

class TeamDisplayedEvent extends Event

  type: 'TeamDisplayed'

  constructor: (@teamid) ->
    super()

module.exports = TeamDisplayedEvent
