Event = require 'framework/Event'

class WorkspaceLoadedEvent extends Event

  constructor: (@workspace) ->
    super()

module.exports = WorkspaceLoadedEvent
