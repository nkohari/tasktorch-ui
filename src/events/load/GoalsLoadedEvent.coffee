DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class GoalsLoadedEvent extends DataLoadedEvent

  type: 'GoalsLoaded'

  constructor: (@goals) ->

module.exports = GoalsLoadedEvent
