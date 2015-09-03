DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class StacksByTeamLoadedEvent extends DataLoadedEvent

  type: 'StacksByTeamLoaded'

  constructor: (@teamid, @stacks) ->

module.exports = StacksByTeamLoadedEvent
