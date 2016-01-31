DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class FilesLoadedEvent extends DataLoadedEvent

  type: 'FilesLoaded'

  constructor: (@files) ->

module.exports = FilesLoadedEvent
