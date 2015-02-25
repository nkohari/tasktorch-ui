Event = require 'events/framework/Event'

class StagesByKindLoadedEvent extends Event

  type: 'StagesByKindLoaded'

  constructor: (@kindid, @stages) ->

module.exports = StagesByKindLoadedEvent
