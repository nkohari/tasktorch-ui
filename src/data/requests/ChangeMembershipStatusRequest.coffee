Membership             = require 'data/models/Membership'
MembershipChangedEvent = require 'events/change/MembershipChangedEvent'
Request                = require 'data/framework/Request'

class ChangeMembershipStatusRequest extends Request

  constructor: (@membershipid, @status) ->

  create: (identity, agent) ->
    agent.post(@urlFor("/#{identity.orgid}/memberships/#{@membershipid}/status"))
    .withCredentials()
    .send {@status}

  onSuccess: (result, publish) ->
    membership = new Membership(result.membership)
    publish new MembershipChangedEvent(membership)

module.exports = ChangeMembershipStatusRequest
