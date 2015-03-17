Event = require 'events/framework/Event'

class ChecklistsByCardLoadedEvent extends Event

  type: 'ChecklistsByCardLoaded'

  constructor: (@cardid, @checklists) ->

module.exports = ChecklistsByCardLoadedEvent
