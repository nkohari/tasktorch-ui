UiEvent = require 'events/framework/UiEvent'

class UserNavigatedEvent extends UiEvent
  
  type: 'UserNavigated'
  shouldRecord: false

  constructor: (@location) ->

module.exports = UserNavigatedEvent
