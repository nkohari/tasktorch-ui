UiEvent = require 'events/framework/UiEvent'

class UserSelectedOrgEvent extends UiEvent
  
  type: 'UserSelectedOrg'
  shouldRecord: false

  constructor: (@userid, @orgid) ->

module.exports = UserSelectedOrgEvent
