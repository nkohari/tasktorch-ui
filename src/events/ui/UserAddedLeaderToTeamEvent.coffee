Event = require 'events/framework/Event'

class UserAddedLeaderToTeamEvent extends Event
  
  type: 'UserAddedLeaderToTeam'

  constructor: (@teamid, @userid) ->

module.exports = UserAddedLeaderToTeamEvent
