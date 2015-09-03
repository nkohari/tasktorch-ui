UiEvent = require 'events/framework/UiEvent'

class UserRemovedCardFromGoalEvent extends UiEvent
  
  type: 'UserRemovedCardFromGoal'

  constructor: (@goalid, @cardid) ->

module.exports = UserRemovedCardFromGoalEvent
