UiEvent = require 'events/framework/UiEvent'

class UserAddedLeaderToTeamEvent extends UiEvent
  
  type: 'UserAddedLeaderToTeam'

  constructor: (@teamid, @userid) ->

module.exports = UserAddedLeaderToTeamEvent
