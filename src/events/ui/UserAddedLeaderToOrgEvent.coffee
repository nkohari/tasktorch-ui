UiEvent = require 'events/framework/UiEvent'

class UserAddedLeaderToOrgEvent extends UiEvent
  
  type: 'UserAddedLeaderToOrg'

  constructor: (@orgid, @userid) ->

module.exports = UserAddedLeaderToOrgEvent
