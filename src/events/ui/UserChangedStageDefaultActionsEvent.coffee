Event = require 'events/framework/Event'

class UserChangedStageDefaultActionsEvent extends Event

  type: 'UserChangedStageDefaultActions'

  constructor: (@stageid, @defaultActions) ->

module.exports = UserChangedStageDefaultActionsEvent
