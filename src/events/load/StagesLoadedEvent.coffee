Event = require 'framework/Event'

class StagesLoadedEvent extends Event

  type: 'StagesLoaded'

  constructor: (@stages) ->
    super()

module.exports = StagesLoadedEvent
