UiEvent = require 'events/framework/UiEvent'

class UserRemovedFileFromCardEvent extends UiEvent
  
  type: 'UserRemovedFileFromCard'

  constructor: (@cardid, @fileid) ->

module.exports = UserRemovedFileFromCardEvent
