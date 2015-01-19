Event = require 'framework/Event'

class ActionChangedEvent extends Event

  constructor: (@action) ->
    super()

module.exports = ActionChangedEvent
