Event = require 'framework/Event'

class OrgsLoadedEvent extends Event

  type: 'OrgsLoaded'

  constructor: (@orgs) ->
    super()

module.exports = OrgsLoadedEvent
