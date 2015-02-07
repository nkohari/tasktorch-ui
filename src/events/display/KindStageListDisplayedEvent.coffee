Event = require 'framework/Event'

class KindStageListDisplayedEvent extends Event

  type: 'KindStageListDisplayed'

  constructor: (@kindid, @stageids) ->
    super()

module.exports = KindStageListDisplayedEvent
