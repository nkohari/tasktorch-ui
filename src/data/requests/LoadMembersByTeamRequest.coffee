_                        = require 'lodash'
Request                  = require 'data/framework/Request'
User                     = require 'data/models/User'
UsersLoadedEvent         = require 'events/load/UsersLoadedEvent'
MembersByTeamLoadedEvent = require 'events/load/MembersByTeamLoadedEvent'

class LoadMembersByTeamRequest extends Request

  constructor: (@teamid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/members"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    users = _.map result.users, (data) -> new User(data)
    publish new UsersLoadedEvent(users)
    publish new MembersByTeamLoadedEvent(@teamid, users)

module.exports = LoadMembersByTeamRequest
