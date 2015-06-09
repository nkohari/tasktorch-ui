Event = require 'events/framework/Event'

class GoalsByCardLoadedEvent extends Event

  type: 'GoalsByCardLoaded'

  constructor: (@cardid, @goals) ->

module.exports = GoalsByCardLoadedEvent
