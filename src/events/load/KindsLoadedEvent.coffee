Event = require 'events/framework/Event'

class KindsLoadedEvent extends Event

  type: 'KindsLoaded'

  constructor: (@kinds) ->

module.exports = KindsLoadedEvent
