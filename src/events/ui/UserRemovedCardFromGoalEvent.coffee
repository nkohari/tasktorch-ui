Event = require 'events/framework/Event'

class UserRemovedCardFromGoalEvent extends Event
  
  type: 'UserRemovedCardFromGoal'

  constructor: (@goalid, @cardid) ->

module.exports = UserRemovedCardFromGoalEvent
