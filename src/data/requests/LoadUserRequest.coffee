superagent       = require 'superagent'
User             = require 'data/models/User'
UsersLoadedEvent = require 'events/load/UsersLoadedEvent'
Request          = require 'data/framework/Request'

class LoadUserRequest extends Request

  constructor: (@userid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/members/#{@userid}"))
    .withCredentials()
    .end (err, res) =>
      user = new User(res.body.user)
      eventQueue.publish new UsersLoadedEvent([user])

module.exports = LoadUserRequest
