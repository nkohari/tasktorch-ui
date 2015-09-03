UiEvent = require 'events/framework/UiEvent'

class UserDeletedStageEvent extends UiEvent

  type: 'UserDeletedStage'

  constructor: (@stageid, @inheritorStage) ->

module.exports = UserDeletedStageEvent
