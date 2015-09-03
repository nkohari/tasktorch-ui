DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class UsersByOrgLoadedEvent extends DataLoadedEvent

  type: 'UsersByOrgLoaded'

  constructor: (@orgid, @users) ->

module.exports = UsersByOrgLoadedEvent
