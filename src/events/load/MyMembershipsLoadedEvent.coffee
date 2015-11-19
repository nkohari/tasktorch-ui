DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class MyMembershipsLoadedEvent extends DataLoadedEvent

  type: 'MyMembershipsLoaded'

  constructor: (@memberships) ->

module.exports = MyMembershipsLoadedEvent
