Event = require 'events/framework/Event'

class StagesLoadedEvent extends Event

  type: 'StagesLoaded'

  constructor: (@stages) ->

module.exports = StagesLoadedEvent
