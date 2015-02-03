Event = require 'framework/Event'

class KindStageListDisplayedEvent extends Event

  type: 'KindStageListDisplayed'

  constructor: (@kindId, @stageIds) ->
    super()

module.exports = KindStageListDisplayedEvent
