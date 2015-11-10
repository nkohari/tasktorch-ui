Membership             = require 'data/models/Membership'
MembershipChangedEvent = require 'events/change/MembershipChangedEvent'
Request                = require 'data/framework/Request'

class ChangeMembershipLevelRequest extends Request

  constructor: (@membershipid, @level) ->

  create: (identity, agent) ->
    agent.post(@urlFor("/#{identity.orgid}/memberships/#{@membershipid}/level"))
    .withCredentials()
    .send {@level}

  onSuccess: (result, publish) ->
    membership = new Membership(result.membership)
    publish new MembershipChangedEvent(membership)

module.exports = ChangeMembershipLevelRequest
