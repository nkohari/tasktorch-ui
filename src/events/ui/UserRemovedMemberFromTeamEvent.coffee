UiEvent = require 'events/framework/UiEvent'

class UserRemovedMemberFromTeamEvent extends UiEvent
  
  type: 'UserRemovedMemberFromTeam'

  constructor: (@teamid, @userid) ->

module.exports = UserRemovedMemberFromTeamEvent
