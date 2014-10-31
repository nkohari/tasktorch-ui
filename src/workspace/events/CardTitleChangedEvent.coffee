Event = require '../../framework/Event'

class CardTitleChangedEvent extends Event

  constructor: (@id, @title, @version) ->
    super()

module.exports = CardTitleChangedEvent
