Event = require 'events/framework/Event'

class UserUnfollowedCardEvent extends Event

  type: 'UserUnfollowedCard'

  constructor: (@cardid, @userid) ->

module.exports = UserUnfollowedCardEvent
