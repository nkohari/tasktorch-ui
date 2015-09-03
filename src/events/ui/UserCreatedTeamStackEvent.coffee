UiEvent = require 'events/framework/UiEvent'

class UserCreatedTeamStackEvent extends UiEvent

  type: 'UserCreatedTeamStack'

  constructor: (@teamid, @name) ->

module.exports = UserCreatedTeamStackEvent
