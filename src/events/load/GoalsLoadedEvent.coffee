Event = require 'events/framework/Event'

class GoalsLoadedEvent extends Event

  type: 'GoalsLoaded'

  constructor: (@goals) ->

module.exports = GoalsLoadedEvent
