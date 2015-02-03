Event = require 'framework/Event'

class KindDisplayedEvent extends Event

  type: 'KindDisplayed'

  constructor: (@kindId) ->
    super()

module.exports = KindDisplayedEvent
