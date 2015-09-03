DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class ChecklistsLoadedEvent extends DataLoadedEvent

  type: 'ChecklistsLoaded'

  constructor: (@checklists) ->

module.exports = ChecklistsLoadedEvent
