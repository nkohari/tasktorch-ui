DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class GoalDeletedEvent extends DocumentDeletedEvent

  type: 'GoalDeleted'

  constructor: (@goal, origin) ->
    super(origin)

module.exports = GoalDeletedEvent
