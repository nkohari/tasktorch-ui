UiEvent = require 'events/framework/UiEvent'

class UserCreatedFileEvent extends UiEvent

  type: 'UserCreatedFile'

  constructor: (@orgid, @cardid, @file, @callbacks) ->

module.exports = UserCreatedFileEvent
