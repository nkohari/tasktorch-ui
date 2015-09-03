DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class GoalsByOrgLoadedEvent extends DataLoadedEvent

  type: 'GoalsByOrgLoaded'

  constructor: (@orgid, @goals) ->

module.exports = GoalsByOrgLoadedEvent
