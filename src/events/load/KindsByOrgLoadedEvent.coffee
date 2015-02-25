Event = require 'events/framework/Event'

class KindsByOrgLoadedEvent extends Event

  type: 'KindsByOrgLoaded'

  constructor: (@orgid, @kinds) ->

module.exports = KindsByOrgLoadedEvent
