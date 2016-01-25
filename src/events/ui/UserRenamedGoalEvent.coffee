UiEvent = require 'events/framework/UiEvent'

class UserRenamedGoalEvent extends UiEvent

  type: 'UserRenamedGoal'

  constructor: (@goalid, @name) ->

module.exports = UserRenamedGoalEvent
