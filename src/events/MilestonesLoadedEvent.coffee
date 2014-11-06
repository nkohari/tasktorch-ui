Event = require '../framework/Event'

class MilestonesLoadedEvent extends Event

  constructor: (@milestones) ->
    super()

module.exports = MilestonesLoadedEvent
