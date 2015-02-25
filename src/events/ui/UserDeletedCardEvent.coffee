Event = require 'events/framework/Event'

class UserDeletedCardEvent extends Event

  type: 'UserDeletedCard'

  constructor: (@cardid) ->

module.exports = UserDeletedCardEvent
