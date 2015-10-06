UiEvent = require 'events/framework/UiEvent'

class UserClosedDrawerEvent extends UiEvent
  
  type: 'UserClosedDrawer'
  shouldRecord: false

  constructor: (@screen) ->

module.exports = UserClosedDrawerEvent
