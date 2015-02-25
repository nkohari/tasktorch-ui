Event = require 'events/framework/Event'

class StacksByTeamLoadedEvent extends Event

  type: 'StacksByTeamLoaded'

  constructor: (@teamid, @stacks) ->

module.exports = StacksByTeamLoadedEvent
