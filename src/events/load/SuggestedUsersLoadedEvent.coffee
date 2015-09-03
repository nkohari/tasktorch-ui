DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class SuggestedUsersLoadedEvent extends DataLoadedEvent

  type: 'SuggestedUsersLoaded'

  constructor: (@phrase, @users) ->

module.exports = SuggestedUsersLoadedEvent
