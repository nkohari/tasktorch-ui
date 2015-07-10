Event = require 'events/framework/Event'

class UserChangedKindColorEvent extends Event

  type: 'UserChangedKindColor'

  constructor: (@kindid, @color) ->

module.exports = UserChangedKindColorEvent
