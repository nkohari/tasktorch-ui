Event = require 'events/framework/Event'

class TeamsLoadedEvent extends Event

  type: 'TeamsLoaded'

  constructor: (@teams) ->

module.exports = TeamsLoadedEvent
