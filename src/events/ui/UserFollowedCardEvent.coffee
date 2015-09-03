UiEvent = require 'events/framework/UiEvent'

class UserFollowedCardEvent extends UiEvent

  type: 'UserFollowedCard'

  constructor: (@cardid, @userid) ->

module.exports = UserFollowedCardEvent
