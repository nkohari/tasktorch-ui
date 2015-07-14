Event = require 'events/framework/Event'

class UserAddedLeaderToOrgEvent extends Event
  
  type: 'UserAddedLeaderToOrg'

  constructor: (@orgid, @userid) ->

module.exports = UserAddedLeaderToOrgEvent
