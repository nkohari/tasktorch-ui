UiEvent = require 'events/framework/UiEvent'

class UserCreatedGoalEvent extends UiEvent

  type: 'UserCreatedGoal'

  constructor: (@orgid, @name, @description, @timeframe) ->

module.exports = UserCreatedGoalEvent
