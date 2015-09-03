UiEvent = require 'events/framework/UiEvent'

class UserAddedMemberToTeamEvent extends UiEvent
  
  type: 'UserAddedMemberToTeam'

  constructor: (@teamid, @userid) ->

module.exports = UserAddedMemberToTeamEvent
