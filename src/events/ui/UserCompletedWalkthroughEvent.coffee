UiEvent = require 'events/framework/UiEvent'

class UserCompletedWalkthroughEvent extends UiEvent

  type: 'UserCompletedWalkthrough'

module.exports = UserCompletedWalkthroughEvent
