Event = require 'events/framework/Event'

class ActionsByCardLoadedEvent extends Event

  type: 'ActionsByCardLoaded'

  constructor: (@cardid, @actions) ->

module.exports = ActionsByCardLoadedEvent
