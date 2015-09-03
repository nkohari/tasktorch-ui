UiEvent = require 'events/framework/UiEvent'

class UserChangedStageDefaultActionsEvent extends UiEvent

  type: 'UserChangedStageDefaultActions'

  constructor: (@stageid, @defaultActions) ->

module.exports = UserChangedStageDefaultActionsEvent
