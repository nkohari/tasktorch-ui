DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class StagesByKindLoadedEvent extends DataLoadedEvent

  type: 'StagesByKindLoaded'

  constructor: (@kindid, @stages) ->

module.exports = StagesByKindLoadedEvent
