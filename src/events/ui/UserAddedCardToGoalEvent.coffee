Event = require 'events/framework/Event'

class UserAddedCardToGoalEvent extends Event
  
  type: 'UserAddedCardToGoal'

  constructor: (@goalid, @cardid) ->

module.exports = UserAddedCardToGoalEvent
