Event = require 'events/framework/Event'

class UserRemovedMemberFromOrgEvent extends Event
  
  type: 'UserRemovedMemberFromOrg'

  constructor: (@orgid, @userid) ->

module.exports = UserRemovedMemberFromOrgEvent
