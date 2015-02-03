Event = require 'framework/Event'

class TeamChangedEvent extends Event

  type: 'TeamChanged'

  constructor: (@team) ->
    super()

module.exports = TeamChangedEvent
