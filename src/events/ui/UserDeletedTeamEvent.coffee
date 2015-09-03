UiEvent = require 'events/framework/UiEvent'

class UserDeletedTeamEvent extends UiEvent

  type: 'UserDeletedTeam'

  constructor: (@teamid) ->

module.exports = UserDeletedTeamEvent
