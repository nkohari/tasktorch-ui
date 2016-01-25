UiEvent = require 'events/framework/UiEvent'

class UserChangedGoalTimeframeEvent extends UiEvent

  type: 'UserChangedGoalTimeframe'

  constructor: (@goalid, @timeframe) ->

module.exports = UserChangedGoalTimeframeEvent
