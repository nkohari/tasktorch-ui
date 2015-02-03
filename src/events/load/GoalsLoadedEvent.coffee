Event = require 'framework/Event'

class GoalsLoadedEvent extends Event

  type: 'GoalsLoaded'

  constructor: (@goals) ->
    super()

module.exports = GoalsLoadedEvent
