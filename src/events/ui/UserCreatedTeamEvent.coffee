Event = require 'events/framework/Event'

class UserCreatedTeamEvent extends Event

  type: 'UserCreatedTeam'

  constructor: (@name) ->

module.exports = UserCreatedTeamEvent
