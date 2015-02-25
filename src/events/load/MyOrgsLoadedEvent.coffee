Event = require 'events/framework/Event'

class MyOrgsLoadedEvent extends Event

  type: 'MyOrgsLoaded'

  constructor: (@orgs) ->

module.exports = MyOrgsLoadedEvent
