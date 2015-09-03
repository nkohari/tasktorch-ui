DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class OrgsLoadedEvent extends DataLoadedEvent

  type: 'OrgsLoaded'

  constructor: (@orgs) ->

module.exports = OrgsLoadedEvent
