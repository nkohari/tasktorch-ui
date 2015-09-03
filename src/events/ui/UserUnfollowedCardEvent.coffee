UiEvent = require 'events/framework/UiEvent'

class UserUnfollowedCardEvent extends UiEvent

  type: 'UserUnfollowedCard'

  constructor: (@cardid, @userid) ->

module.exports = UserUnfollowedCardEvent
