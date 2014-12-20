Event = require 'framework/Event'

class KindDisplayedEvent extends Event

  constructor: (@kindId) ->
    super()

module.exports = KindDisplayedEvent
