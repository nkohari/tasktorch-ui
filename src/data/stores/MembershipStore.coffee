Membership                    = require 'data/models/Membership'
ModelStore                    = require 'data/framework/ModelStore'
LoadMembershipRequest         = require 'data/requests/LoadMembershipRequest'
ChangeMembershipLevelRequest  = require 'data/requests/ChangeMembershipLevelRequest'
ChangeMembershipStatusRequest = require 'data/requests/ChangeMembershipStatusRequest'

class MembershipStore extends ModelStore

  name:        'memberships'
  displayName: 'MembershipStore'
  modelType:   Membership

  listensFor: [
    'MembershipsLoaded'
    'MembershipCreated'
    'MembershipChanged'
    'UserChangedMembershipLevel'
    'UserChangedMembershipStatus'
  ]

  load: (membershipid) ->
    @execute new LoadMembershipRequest(membershipid)

  onMembershipsLoaded: (event) ->
    @add(event.memberships)

  onMembershipCreated: (event) ->
    @add(event.membership)

  onMembershipChanged: (event) ->
    @add(event.membership)

  onUserChangedMembershipLevel: (event) ->
    @execute new ChangeMembershipLevelRequest(event.membershipid, event.level)

  onUserChangedMembershipStatus: (event) ->
    @execute new ChangeMembershipStatusRequest(event.membershipid, event.status)

module.exports = MembershipStore
