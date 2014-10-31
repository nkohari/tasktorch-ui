Event = require '../../framework/Event'

class CardTitleChangedEvent extends Event

  constructor: (@id, @title, @version, meta) ->
    super(meta)

module.exports = CardTitleChangedEvent
