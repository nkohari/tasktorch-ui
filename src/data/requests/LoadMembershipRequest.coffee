Membership             = require 'data/models/Membership'
MembershipsLoadedEvent = require 'events/load/MembershipsLoadedEvent'
Request                = require 'data/framework/Request'

class LoadMembershipRequest extends Request

  constructor: (@membershipid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/memberships/#{@membershipid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    membership = new Membership(result.membership)
    publish new MembershipsLoadedEvent([membership])

module.exports = LoadMembershipRequest
