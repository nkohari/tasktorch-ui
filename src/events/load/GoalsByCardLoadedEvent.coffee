DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class GoalsByCardLoadedEvent extends DataLoadedEvent

  type: 'GoalsByCardLoaded'

  constructor: (@cardid, @goals) ->

module.exports = GoalsByCardLoadedEvent
