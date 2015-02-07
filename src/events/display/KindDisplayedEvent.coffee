Event = require 'framework/Event'

class KindDisplayedEvent extends Event

  type: 'KindDisplayed'

  constructor: (@kindid) ->
    super()

module.exports = KindDisplayedEvent
