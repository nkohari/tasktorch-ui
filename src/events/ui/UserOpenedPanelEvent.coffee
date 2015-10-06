UiEvent = require 'events/framework/UiEvent'

class UserOpenedPanelEvent extends UiEvent
  
  type: 'UserOpenedPanel'
  shouldRecord: false

  constructor: (@panel, @options = {}) ->

module.exports = UserOpenedPanelEvent
