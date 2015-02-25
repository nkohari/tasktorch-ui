Event = require 'events/framework/Event'

class UserChangedActionOwnerEvent extends Event

  type: 'UserChangedActionOwner'

  constructor: (@actionid, @userid) ->

module.exports = UserChangedActionOwnerEvent
