Event = require 'events/framework/Event'

class MembersByTeamLoadedEvent extends Event

  type: 'MembersByTeamLoaded'

  constructor: (@teamid, @users) ->

module.exports = MembersByTeamLoadedEvent
