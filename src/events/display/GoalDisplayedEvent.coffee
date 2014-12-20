Event = require 'framework/Event'

class GoalDisplayedEvent extends Event

  constructor: (@goalId) ->
    super()

module.exports = GoalDisplayedEvent
