UiEvent = require 'events/framework/UiEvent'

class UserSelectedScreenEvent extends UiEvent
  
  type: 'UserSelectedScreen'
  shouldRecord: false

  constructor: (@screen) ->

module.exports = UserSelectedScreenEvent
