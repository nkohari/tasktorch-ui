superagent       = require 'superagent'
User             = require 'data/models/User'
UsersLoadedEvent = require 'events/load/UsersLoadedEvent'
Request          = require 'data/framework/Request'

class LoadUserRequest extends Request

  constructor: (@userid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/members/#{@userid}", (res) =>
      user = new User(res.body.user)
      eventQueue.publish new UsersLoadedEvent([user])

module.exports = LoadUserRequest
