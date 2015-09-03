UiEvent = require 'events/framework/UiEvent'

class UserChangedKindDescriptionEvent extends UiEvent

  type: 'UserChangedKindDescription'

  constructor: (@kindid, @description) ->

module.exports = UserChangedKindDescriptionEvent
