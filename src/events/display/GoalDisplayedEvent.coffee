Event = require 'framework/Event'

class GoalDisplayedEvent extends Event

  type: 'GoalDisplayed'

  constructor: (@goalid) ->
    super()

module.exports = GoalDisplayedEvent
