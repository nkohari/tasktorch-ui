Event = require 'events/framework/Event'

class UserChangedNameEvent extends Event

  type: 'UserChangedName'

  constructor: (@name) ->

module.exports = UserChangedNameEvent
