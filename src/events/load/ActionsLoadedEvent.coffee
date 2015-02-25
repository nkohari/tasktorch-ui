Event = require 'events/framework/Event'

class ActionsLoadedEvent extends Event

  type: 'ActionsLoaded'

  constructor: (@actions) ->

module.exports = ActionsLoadedEvent
