Event = require 'events/framework/Event'

class UserCreatedTeamEvent extends Event

  type: 'UserCreatedTeam'

  constructor: (@name, @purpose, @members, @leaders) ->

module.exports = UserCreatedTeamEvent
