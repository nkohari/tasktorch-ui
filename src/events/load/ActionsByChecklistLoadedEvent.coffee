DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class ActionsByChecklistLoadedEvent extends DataLoadedEvent

  type: 'ActionsByChecklistLoaded'

  constructor: (@checklistid, @actions) ->

module.exports = ActionsByChecklistLoadedEvent
