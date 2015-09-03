UiEvent = require 'events/framework/UiEvent'

class UserCreatedTeamEvent extends UiEvent

  type: 'UserCreatedTeam'

  constructor: (@name, @purpose, @members, @leaders) ->

module.exports = UserCreatedTeamEvent
