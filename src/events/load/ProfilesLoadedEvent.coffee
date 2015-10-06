DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class ProfilesLoadedEvent extends DataLoadedEvent

  type: 'ProfilesLoaded'

  constructor: (@profiles) ->

module.exports = ProfilesLoadedEvent
