UiEvent = require 'events/framework/UiEvent'

class UserChangedActionOwnerEvent extends UiEvent

  type: 'UserChangedActionOwner'

  constructor: (@actionid, @userid) ->

module.exports = UserChangedActionOwnerEvent
