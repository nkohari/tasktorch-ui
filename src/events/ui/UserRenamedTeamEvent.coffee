UiEvent = require 'events/framework/UiEvent'

class UserRenamedTeamEvent extends UiEvent

  type: 'UserRenamedTeam'

  constructor: (@teamid, @name) ->

module.exports = UserRenamedTeamEvent
