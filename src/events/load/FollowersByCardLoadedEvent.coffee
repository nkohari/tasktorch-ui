Event = require 'events/framework/Event'

class FollowersByCardLoadedEvent extends Event

  type: 'FollowersByCardLoaded'

  constructor: (@cardid, @users) ->

module.exports = FollowersByCardLoadedEvent
