_                         = require 'lodash'
superagent                = require 'superagent'
User                      = require 'data/models/User'
Request                   = require 'data/framework/Request'
UsersLoadedEvent          = require 'events/load/UsersLoadedEvent'
SuggestedUsersLoadedEvent = require 'events/load/SuggestedUsersLoadedEvent'

class LoadSuggestedUsersRequest extends Request

  constructor: (@phrase) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/members?suggest=#{@phrase}", (res) =>
      users = _.map res.body.users, (doc) -> new User(doc)
      eventQueue.publish new UsersLoadedEvent(users)
      eventQueue.publish new SuggestedUsersLoadedEvent(@phrase, users)

module.exports = LoadSuggestedUsersRequest
