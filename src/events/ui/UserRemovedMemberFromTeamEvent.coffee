Event = require 'events/framework/Event'

class UserRemovedMemberFromTeamEvent extends Event
  
  type: 'UserRemovedMemberFromTeam'

  constructor: (@teamid, @userid) ->

module.exports = UserRemovedMemberFromTeamEvent
