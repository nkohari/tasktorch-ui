Event = require 'events/framework/Event'

class UserFollowedCardEvent extends Event

  type: 'UserFollowedCard'

  constructor: (@cardid, @userid) ->

module.exports = UserFollowedCardEvent
