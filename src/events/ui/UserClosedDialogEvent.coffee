UiEvent = require 'events/framework/UiEvent'

class UserClosedDialogEvent extends UiEvent
  
  type: 'UserClosedDialog'
  shouldRecord: false

  constructor: (@name) ->

module.exports = UserClosedDialogEvent
