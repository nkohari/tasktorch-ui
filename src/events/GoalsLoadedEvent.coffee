Event = require '../framework/Event'

class GoalsLoadedEvent extends Event

  constructor: (@goals) ->
    super()

module.exports = GoalsLoadedEvent
