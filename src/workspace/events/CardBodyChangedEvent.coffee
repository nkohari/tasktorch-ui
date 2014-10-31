Event = require '../../framework/Event'

class CardBodyChangedEvent extends Event

  constructor: (@id, @body, @version) ->
    super()

module.exports = CardBodyChangedEvent
