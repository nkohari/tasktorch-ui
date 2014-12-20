Event = require 'framework/Event'

class KindStageListDisplayedEvent extends Event

  constructor: (@kindId, @stageIds) ->
    super()

module.exports = KindStageListDisplayedEvent
