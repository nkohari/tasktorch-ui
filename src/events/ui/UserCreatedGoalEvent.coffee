UiEvent = require 'events/framework/UiEvent'

class UserCreatedGoalEvent extends UiEvent

  type: 'UserCreatedGoal'

  constructor: (@name) ->

module.exports = UserCreatedGoalEvent
