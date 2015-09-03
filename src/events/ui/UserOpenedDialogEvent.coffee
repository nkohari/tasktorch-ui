UiEvent = require 'events/framework/UiEvent'

class UserOpenedDialogEvent extends UiEvent
  
  type: 'UserOpenedDialog'
  shouldRecord: false

  constructor: (@name, @props = {}) ->

module.exports = UserOpenedDialogEvent
