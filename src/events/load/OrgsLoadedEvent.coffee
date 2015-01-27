Event = require 'framework/Event'

class OrgsLoadedEvent extends Event

  constructor: (@orgs) ->
    super()

module.exports = OrgsLoadedEvent
