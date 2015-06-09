Event = require 'events/framework/Event'

class UserCreatedGoalEvent extends Event

  type: 'UserCreatedGoal'

  constructor: (@name) ->

module.exports = UserCreatedGoalEvent
