Event = require 'events/framework/Event'

class UserRemovedLeaderFromOrgEvent extends Event
  
  type: 'UserRemovedLeaderFromOrg'

  constructor: (@orgid, @userid) ->

module.exports = UserRemovedLeaderFromOrgEvent
