_                        = require 'lodash'
superagent               = require 'superagent'
Request                  = require 'data/framework/Request'
User                     = require 'data/models/User'
UsersLoadedEvent         = require 'events/load/UsersLoadedEvent'
MembersByTeamLoadedEvent = require 'events/load/MembersByTeamLoadedEvent'

class LoadMembersByTeamRequest extends Request

  constructor: (@teamid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/teams/#{@teamid}/members", (res) =>
      users = _.map res.body.users, (data) -> new User(data)
      eventQueue.publish new UsersLoadedEvent(users)
      eventQueue.publish new MembersByTeamLoadedEvent(@teamid, users)

module.exports = LoadMembersByTeamRequest
