UiEvent = require 'events/framework/UiEvent'

class UserLoggedOutEvent extends UiEvent

  type: 'UserLoggedOut'

module.exports = UserLoggedOutEvent
