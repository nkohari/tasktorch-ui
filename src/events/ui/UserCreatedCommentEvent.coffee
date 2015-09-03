UiEvent = require 'events/framework/UiEvent'

class UserCreatedCommentEvent extends UiEvent

  type: 'UserCreatedComment'

  constructor: (@cardid, @content) ->

module.exports = UserCreatedCommentEvent
