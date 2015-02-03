Event = require 'framework/Event'

class KindsLoadedEvent extends Event

  type: 'KindsLoaded'

  constructor: (@kinds) ->
    super()

module.exports = KindsLoadedEvent
