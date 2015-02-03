Event = require 'framework/Event'

class TeamCreatedEvent extends Event

  type: 'TeamCreated'

  constructor: (@team) ->
    super()

module.exports = TeamCreatedEvent
