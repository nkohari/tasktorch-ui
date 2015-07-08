Event = require 'events/framework/Event'

class UserDeletedStageEvent extends Event

  type: 'UserDeletedStage'

  constructor: (@stageid, @inheritorStage) ->

module.exports = UserDeletedStageEvent
