DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class KindsByOrgLoadedEvent extends DataLoadedEvent

  type: 'KindsByOrgLoaded'

  constructor: (@orgid, @kinds) ->

module.exports = KindsByOrgLoadedEvent
