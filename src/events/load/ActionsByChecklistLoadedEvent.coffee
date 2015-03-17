Event = require 'events/framework/Event'

class ActionsByChecklistLoadedEvent extends Event

  type: 'ActionsByChecklistLoaded'

  constructor: (@checklistid, @actions) ->

module.exports = ActionsByChecklistLoadedEvent
