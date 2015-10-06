UiEvent = require 'events/framework/UiEvent'

class UserChangedTitleEvent extends UiEvent

  type: 'UserChangedTitle'

  constructor: (@title) ->

module.exports = UserChangedTitleEvent
