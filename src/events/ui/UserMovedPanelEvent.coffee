UiEvent = require 'events/framework/UiEvent'

class UserMovedPanelEvent extends UiEvent
  
  type: 'UserMovedPanel'
  shouldRecord: false

  constructor: (@id, @newPosition) ->

module.exports = UserMovedPanelEvent
