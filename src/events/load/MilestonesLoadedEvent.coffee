Event = require 'framework/Event'

class MilestonesLoadedEvent extends Event

  type: 'MilestonesLoaded'

  constructor: (@milestones) ->
    super()

module.exports = MilestonesLoadedEvent
