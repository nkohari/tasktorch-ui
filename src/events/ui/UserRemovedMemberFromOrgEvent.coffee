UiEvent = require 'events/framework/UiEvent'

class UserRemovedMemberFromOrgEvent extends UiEvent
  
  type: 'UserRemovedMemberFromOrg'

  constructor: (@orgid, @userid) ->

module.exports = UserRemovedMemberFromOrgEvent
