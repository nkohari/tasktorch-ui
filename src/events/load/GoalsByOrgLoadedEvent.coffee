Event = require 'events/framework/Event'

class GoalsByOrgLoadedEvent extends Event

  type: 'GoalsByOrgLoaded'

  constructor: (@orgid, @goals) ->

module.exports = GoalsByOrgLoadedEvent
