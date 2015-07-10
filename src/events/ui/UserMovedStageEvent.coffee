Event = require 'events/framework/Event'

class UserMovedStageEvent extends Event

  type: 'UserMovedStage'

  constructor: (@stageid, @position) ->

module.exports = UserMovedStageEvent
