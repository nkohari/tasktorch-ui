UiEvent = require 'events/framework/UiEvent'

class UserChangedGoalStatusEvent extends UiEvent

  type: 'UserChangedGoalStatus'

  constructor: (@goalid, @status) ->

module.exports = UserChangedGoalStatusEvent
