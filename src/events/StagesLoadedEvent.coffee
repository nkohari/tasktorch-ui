Event = require 'framework/Event'

class StagesLoadedEvent extends Event

  constructor: (@stages) ->
    super()

module.exports = StagesLoadedEvent
