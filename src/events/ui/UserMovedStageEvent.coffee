UiEvent = require 'events/framework/UiEvent'

class UserMovedStageEvent extends UiEvent

  type: 'UserMovedStage'

  constructor: (@stageid, @position) ->

module.exports = UserMovedStageEvent
