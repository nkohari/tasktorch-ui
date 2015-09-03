DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class KindsLoadedEvent extends DataLoadedEvent

  type: 'KindsLoaded'

  constructor: (@kinds) ->

module.exports = KindsLoadedEvent
