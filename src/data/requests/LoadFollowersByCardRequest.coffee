_                          = require 'lodash'
superagent                 = require 'superagent'
User                       = require 'data/models/User'
UsersLoadedEvent           = require 'events/load/UsersLoadedEvent'
FollowersByCardLoadedEvent = require 'events/load/FollowersByCardLoadedEvent'
Request                    = require 'data/framework/Request'

class LoadFollowersByCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/cards/#{@cardid}/followers", (res) =>
      users = _.map res.body.users, (doc) -> new User(doc)
      eventQueue.publish new UsersLoadedEvent(users)
      eventQueue.publish new FollowersByCardLoadedEvent(@cardid, users)

module.exports = LoadFollowersByCardRequest
