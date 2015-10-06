UiEvent = require 'events/framework/UiEvent'

class UserOpenedDrawerEvent extends UiEvent
  
  type: 'UserOpenedDrawer'
  shouldRecord: false

module.exports = UserOpenedDrawerEvent
