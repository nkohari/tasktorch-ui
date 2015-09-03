UiEvent = require 'events/framework/UiEvent'

class UserRemovedLeaderFromOrgEvent extends UiEvent
  
  type: 'UserRemovedLeaderFromOrg'

  constructor: (@orgid, @userid) ->

module.exports = UserRemovedLeaderFromOrgEvent
