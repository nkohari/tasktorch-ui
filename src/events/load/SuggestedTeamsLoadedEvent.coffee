DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class SuggestedTeamsLoadedEvent extends DataLoadedEvent

  type: 'SuggestedTeamsLoaded'

  constructor: (@phrase, @teams) ->

module.exports = SuggestedTeamsLoadedEvent
