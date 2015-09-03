DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class TeamsLoadedEvent extends DataLoadedEvent

  type: 'TeamsLoaded'

  constructor: (@teams) ->

module.exports = TeamsLoadedEvent
