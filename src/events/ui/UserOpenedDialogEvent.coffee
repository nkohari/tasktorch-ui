Event = require 'events/framework/Event'

class UserOpenedDialogEvent extends Event
  
  type: 'UserOpenedDialog'

  constructor: (@name, @props = {}) ->

module.exports = UserOpenedDialogEvent
