UiEvent = require 'events/framework/UiEvent'

class UserChangedGoalDescriptionEvent extends UiEvent

  type: 'UserChangedGoalDescription'

  constructor: (@goalid, @description) ->

module.exports = UserChangedGoalDescriptionEvent
