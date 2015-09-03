UiEvent = require 'events/framework/UiEvent'

class UserAddedCardToGoalEvent extends UiEvent
  
  type: 'UserAddedCardToGoal'

  constructor: (@goalid, @cardid) ->

module.exports = UserAddedCardToGoalEvent
