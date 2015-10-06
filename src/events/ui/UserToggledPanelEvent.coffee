UiEvent = require 'events/framework/UiEvent'

class UserToggledPanelEvent extends UiEvent
  
  type: 'UserToggledPanel'
  shouldRecord: false

  constructor: (@panel) ->

module.exports = UserToggledPanelEvent
