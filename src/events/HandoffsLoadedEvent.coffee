Event = require 'framework/Event'

class HandoffsLoadedEvent extends Event

  constructor: (@handoffs) ->
    super()

module.exports = HandoffsLoadedEvent
