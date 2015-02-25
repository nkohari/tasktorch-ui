Event = require 'events/framework/Event'

class SuggestedTeamsLoadedEvent extends Event

  type: 'SuggestedTeamsLoaded'

  constructor: (@phrase, @teams) ->

module.exports = SuggestedTeamsLoadedEvent
