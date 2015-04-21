Event = require 'events/framework/Event'

class UserRemovedLeaderFromTeamEvent extends Event
  
  type: 'UserRemovedLeaderFromTeam'

  constructor: (@teamid, @userid) ->

module.exports = UserRemovedLeaderFromTeamEvent
