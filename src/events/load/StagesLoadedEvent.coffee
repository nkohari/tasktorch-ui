DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class StagesLoadedEvent extends DataLoadedEvent

  type: 'StagesLoaded'

  constructor: (@stages) ->

module.exports = StagesLoadedEvent
