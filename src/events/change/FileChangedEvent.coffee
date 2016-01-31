DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class FileChangedEvent extends DocumentChangedEvent

  type: 'FileChanged'

  constructor: (@file, origin) ->
    super(origin)

module.exports = FileChangedEvent
