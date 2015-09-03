UiEvent = require 'events/framework/UiEvent'

class UserDeletedCardEvent extends UiEvent

  type: 'UserDeletedCard'

  constructor: (@cardid) ->

module.exports = UserDeletedCardEvent
