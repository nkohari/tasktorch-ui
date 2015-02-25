Event = require 'events/framework/Event'

class MyTeamsLoadedEvent extends Event

  type: 'MyTeamsLoaded'

  constructor: (@teams) ->

module.exports = MyTeamsLoadedEvent
