DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class FilesByCardLoadedEvent extends DataLoadedEvent

  type: 'FilesByCardLoaded'

  constructor: (@cardid, @files) ->

module.exports = FilesByCardLoadedEvent
