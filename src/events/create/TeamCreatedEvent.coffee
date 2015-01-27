Event = require 'framework/Event'

class TeamCreatedEvent extends Event

  constructor: (@team) ->
    super()

module.exports = TeamCreatedEvent
