Event = require 'events/framework/Event'

class UserChangedKindDescriptionEvent extends Event

  type: 'UserChangedKindDescription'

  constructor: (@kindid, @description) ->

module.exports = UserChangedKindDescriptionEvent
