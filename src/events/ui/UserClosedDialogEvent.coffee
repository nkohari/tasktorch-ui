Event = require 'events/framework/Event'

class UserClosedDialogEvent extends Event
  
  type: 'UserClosedDialog'

  constructor: (@name) ->

module.exports = UserClosedDialogEvent
