DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class TeamCreatedEvent extends DocumentCreatedEvent

  type: 'TeamCreated'

  constructor: (@team, origin) ->
    super(origin)

module.exports = TeamCreatedEvent
