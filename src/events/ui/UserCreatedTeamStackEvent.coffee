Event = require 'events/framework/Event'

class UserCreatedTeamStackEvent extends Event

  type: 'UserCreatedTeamStack'

  constructor: (@teamid, @name) ->

module.exports = UserCreatedTeamStackEvent
