UiEvent = require 'events/framework/UiEvent'

class UserChangedBioEvent extends UiEvent

  type: 'UserChangedBio'

  constructor: (@bio) ->

module.exports = UserChangedBioEvent
