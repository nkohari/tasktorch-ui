DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class MyOrgsLoadedEvent extends DataLoadedEvent

  type: 'MyOrgsLoaded'

  constructor: (@orgs) ->

module.exports = MyOrgsLoadedEvent
