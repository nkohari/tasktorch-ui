DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class GoalChangedEvent extends DocumentChangedEvent

  type: 'GoalChanged'

  constructor: (@goal, origin) ->
    super(origin)

module.exports = GoalChangedEvent
