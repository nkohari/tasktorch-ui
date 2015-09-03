UiEvent = require 'events/framework/UiEvent'

class UserCreatedStageEvent extends UiEvent

  type: 'UserCreatedStage'

  constructor: (@kindid, @name) ->

module.exports = UserCreatedStageEvent
