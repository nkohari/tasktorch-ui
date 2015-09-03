DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class FollowersByCardLoadedEvent extends DataLoadedEvent

  type: 'FollowersByCardLoaded'

  constructor: (@cardid, @users) ->

module.exports = FollowersByCardLoadedEvent
