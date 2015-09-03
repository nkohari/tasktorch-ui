UiEvent = require 'events/framework/UiEvent'

class UserRenamedStageEvent extends UiEvent

  type: 'UserRenamedStage'

  constructor: (@stageid, @name) ->

module.exports = UserRenamedStageEvent
