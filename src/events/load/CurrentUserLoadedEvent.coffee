Event = require 'framework/Event'

class CurrentUserLoadedEvent extends Event

  type: 'CurrentUserLoaded'

  constructor: (@user) ->
    super()

module.exports = CurrentUserLoadedEvent
