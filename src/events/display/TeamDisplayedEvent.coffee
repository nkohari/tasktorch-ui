Event = require 'framework/Event'

class TeamDisplayedEvent extends Event

  type: 'TeamDisplayed'

  constructor: (@teamId) ->
    super()

module.exports = TeamDisplayedEvent
