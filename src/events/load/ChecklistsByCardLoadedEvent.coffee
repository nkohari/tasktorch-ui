DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class ChecklistsByCardLoadedEvent extends DataLoadedEvent

  type: 'ChecklistsByCardLoaded'

  constructor: (@cardid, @checklists) ->

module.exports = ChecklistsByCardLoadedEvent
