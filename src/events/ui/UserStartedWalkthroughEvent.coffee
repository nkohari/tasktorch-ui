UiEvent = require 'events/framework/UiEvent'

class UserStartedWalkthroughEvent extends UiEvent

  type: 'UserStartedWalkthrough'

module.exports = UserStartedWalkthroughEvent
