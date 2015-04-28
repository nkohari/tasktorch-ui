Event = require 'events/framework/Event'

class UserChangedPasswordEvent extends Event

  type: 'UserChangedPassword'

  constructor: (@password) ->

module.exports = UserChangedPasswordEvent
