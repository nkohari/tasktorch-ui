Event = require 'events/framework/Event'

class UserAddedMemberToTeamEvent extends Event
  
  type: 'UserAddedMemberToTeam'

  constructor: (@teamid, @userid) ->

module.exports = UserAddedMemberToTeamEvent
