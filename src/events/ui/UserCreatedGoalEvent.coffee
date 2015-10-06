UiEvent = require 'events/framework/UiEvent'

class UserCreatedGoalEvent extends UiEvent

  type: 'UserCreatedGoal'

  constructor: (@orgid, @name) ->

module.exports = UserCreatedGoalEvent
