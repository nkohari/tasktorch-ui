UiEvent = require 'events/framework/UiEvent'

class UserRemovedLeaderFromTeamEvent extends UiEvent
  
  type: 'UserRemovedLeaderFromTeam'

  constructor: (@teamid, @userid) ->

module.exports = UserRemovedLeaderFromTeamEvent
