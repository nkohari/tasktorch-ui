DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class MembershipsLoadedEvent extends DataLoadedEvent

  type: 'MembershipsLoaded'

  constructor: (@memberships) ->

module.exports = MembershipsLoadedEvent
