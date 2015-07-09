Event = require 'events/framework/Event'

class UserCreatedStageEvent extends Event

  type: 'UserCreatedStage'

  constructor: (@kindid, @name, @position) ->

module.exports = UserCreatedStageEvent
