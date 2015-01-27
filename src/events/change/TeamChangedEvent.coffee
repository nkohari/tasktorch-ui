Event = require 'framework/Event'

class TeamChangedEvent extends Event

  constructor: (@team) ->
    super()

module.exports = TeamChangedEvent
