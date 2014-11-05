Event = require '../../framework/Event'

class CardBodyChangedEvent extends Event

  constructor: (@id, @body, @version, meta) ->
    super(meta)

module.exports = CardBodyChangedEvent
