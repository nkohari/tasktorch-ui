Event = require 'events/framework/Event'

class UserCreatedCommentEvent extends Event

  type: 'UserCreatedComment'

  constructor: (@cardid, @content) ->

module.exports = UserCreatedCommentEvent
