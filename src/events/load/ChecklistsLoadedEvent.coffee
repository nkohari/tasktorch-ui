Event = require 'events/framework/Event'

class ChecklistsLoadedEvent extends Event

  type: 'ChecklistsLoaded'

  constructor: (@checklists) ->

module.exports = ChecklistsLoadedEvent
