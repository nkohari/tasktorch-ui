_                           = require 'lodash'
Request                     = require 'data/framework/Request'
Membership                  = require 'data/models/Membership'
User                        = require 'data/models/User'
MembershipsLoadedEvent      = require 'events/load/MembershipsLoadedEvent'
MembershipsByOrgLoadedEvent = require 'events/load/MembershipsByOrgLoadedEvent'
UsersLoadedEvent            = require 'events/load/UsersLoadedEvent'

class LoadMembershipsByOrgRequest extends Request

  constructor: (@orgid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{@orgid}/memberships?expand=user"))
    .withCredentials()
  
  onSuccess: (result, publish) ->

    memberships = _.map result.memberships,    (data) -> new Membership(data)
    users       = _.map result.related?.users, (data) -> new User(data)

    publish new MembershipsLoadedEvent(memberships)
    publish new MembershipsByOrgLoadedEvent(@orgid, memberships)
    publish new UsersLoadedEvent(users)

module.exports = LoadMembershipsByOrgRequest
