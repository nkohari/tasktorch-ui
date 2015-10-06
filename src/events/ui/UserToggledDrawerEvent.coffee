UiEvent = require 'events/framework/UiEvent'

class UserToggledDrawerEvent extends UiEvent
  
  type: 'UserToggledDrawer'
  shouldRecord: false

module.exports = UserToggledDrawerEvent
