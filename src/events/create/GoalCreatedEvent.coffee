DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class GoalCreatedEvent extends DocumentCreatedEvent

  type: 'GoalCreated'

  constructor: (@goal, origin) ->
    super(origin)

module.exports = GoalCreatedEvent
