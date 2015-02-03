Event = require 'framework/Event'

class GoalDisplayedEvent extends Event

  type: 'GoalDisplayed'

  constructor: (@goalId) ->
    super()

module.exports = GoalDisplayedEvent
