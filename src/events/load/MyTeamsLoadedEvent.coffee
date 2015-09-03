DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class MyTeamsLoadedEvent extends DataLoadedEvent

  type: 'MyTeamsLoaded'

  constructor: (@teams) ->

module.exports = MyTeamsLoadedEvent
