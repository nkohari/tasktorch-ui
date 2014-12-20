Event = require 'framework/Event'

class KindsLoadedEvent extends Event

  constructor: (@kinds) ->
    super()

module.exports = KindsLoadedEvent
