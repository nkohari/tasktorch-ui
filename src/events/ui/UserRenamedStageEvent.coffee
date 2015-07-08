Event = require 'events/framework/Event'

class UserRenamedStageEvent extends Event

  type: 'UserRenamedStage'

  constructor: (@stageid, @name) ->

module.exports = UserRenamedStageEvent
