Event = require 'framework/Event'

class ActionChangedEvent extends Event

  type: 'ActionChanged'

  constructor: (@action) ->
    super()

module.exports = ActionChangedEvent
