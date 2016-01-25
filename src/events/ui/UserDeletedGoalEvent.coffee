UiEvent = require 'events/framework/UiEvent'

class UserDeletedGoalEvent extends UiEvent

  type: 'UserDeletedGoal'

  constructor: (@goalid) ->

module.exports = UserDeletedGoalEvent
