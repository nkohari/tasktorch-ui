Event = require 'events/framework/Event'

class UsersByOrgLoadedEvent extends Event

  type: 'UsersByOrgLoaded'

  constructor: (@orgid, @users) ->

module.exports = UsersByOrgLoadedEvent
