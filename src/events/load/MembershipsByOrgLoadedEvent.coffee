DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class MembershipsByOrgLoadedEvent extends DataLoadedEvent

  type: 'MembershipsByOrgLoaded'

  constructor: (@orgid, @memberships) ->

module.exports = MembershipsByOrgLoadedEvent
