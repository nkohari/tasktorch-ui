Event = require '../../framework/Event'

class CurrentUserLoadedEvent extends Event

  constructor: (@user) ->
    super()

module.exports = CurrentUserLoadedEvent
