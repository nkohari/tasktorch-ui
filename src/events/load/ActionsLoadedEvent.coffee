DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class ActionsLoadedEvent extends DataLoadedEvent

  type: 'ActionsLoaded'

  constructor: (@actions) ->

module.exports = ActionsLoadedEvent
