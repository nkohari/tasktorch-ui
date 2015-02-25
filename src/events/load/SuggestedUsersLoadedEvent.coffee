Event = require 'events/framework/Event'

class SuggestedUsersLoadedEvent extends Event

  type: 'SuggestedUsersLoaded'

  constructor: (@phrase, @users) ->

module.exports = SuggestedUsersLoadedEvent
