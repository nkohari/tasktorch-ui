DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class MembersByTeamLoadedEvent extends DataLoadedEvent

  type: 'MembersByTeamLoaded'

  constructor: (@teamid, @users) ->

module.exports = MembersByTeamLoadedEvent
