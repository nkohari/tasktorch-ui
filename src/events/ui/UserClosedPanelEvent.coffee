UiEvent = require 'events/framework/UiEvent'

class UserClosedPanelEvent extends UiEvent
  
  type: 'UserClosedPanel'
  shouldRecord: false

  constructor: (@id) ->

module.exports = UserClosedPanelEvent
