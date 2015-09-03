UiEvent = require 'events/framework/UiEvent'

class UserChangedKindColorEvent extends UiEvent

  type: 'UserChangedKindColor'

  constructor: (@kindid, @color) ->

module.exports = UserChangedKindColorEvent
