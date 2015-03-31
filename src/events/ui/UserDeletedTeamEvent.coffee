Event = require 'events/framework/Event'

class UserDeletedTeamEvent extends Event

  type: 'UserDeletedTeam'

  constructor: (@teamid) ->

module.exports = UserDeletedTeamEvent
