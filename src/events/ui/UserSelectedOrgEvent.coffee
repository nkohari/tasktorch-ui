Event = require 'events/framework/Event'

class UserSelectedOrgEvent extends Event
  
  type: 'UserSelectedOrg'

  constructor: (@userid, @orgid) ->

module.exports = UserSelectedOrgEvent
