Event = require 'events/framework/Event'

class UserRenamedStackEvent extends Event

  type: 'UserRenamedStack'

  constructor: (@stackid, @name) ->

module.exports = UserRenamedStackEvent
