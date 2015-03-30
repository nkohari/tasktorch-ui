Event = require 'events/framework/Event'

class UserRenamedTeamEvent extends Event

  type: 'UserRenamedTeam'

  constructor: (@teamid, @name) ->

module.exports = UserRenamedTeamEvent
