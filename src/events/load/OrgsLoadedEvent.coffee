Event = require 'events/framework/Event'

class OrgsLoadedEvent extends Event

  type: 'OrgsLoaded'

  constructor: (@orgs) ->

module.exports = OrgsLoadedEvent
