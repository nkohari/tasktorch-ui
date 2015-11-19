_                        = require 'lodash'
Membership               = require 'data/models/Membership'
MembershipsLoadedEvent   = require 'events/load/MembershipsLoadedEvent'
MyMembershipsLoadedEvent = require 'events/load/MyMembershipsLoadedEvent'
Request                  = require 'data/framework/Request'

class LoadMyMembershipsRequest extends Request

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/me/memberships"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    memberships = _.map result.memberships, (doc) -> new Membership(doc)
    publish new MembershipsLoadedEvent(memberships)
    publish new MyMembershipsLoadedEvent(memberships)

module.exports = LoadMyMembershipsRequest
