_                           = require 'lodash'
ListStore                   = require 'data/framework/ListStore'
LoadMembershipsByOrgRequest = require 'data/requests/LoadMembershipsByOrgRequest'

class MembershipsByOrgStore extends ListStore

  displayName: 'MembershipsByOrgStore'
  name:        'membershipsByOrg'
  dependsOn:   'memberships'

  listensFor: [
    'MembershipsByOrgLoaded'
  ]

  load: (id) ->
    @execute new LoadMembershipsByOrgRequest(id)

  onMembershipsByOrgLoaded: (event) ->
    @set(event.orgid, _.map(event.memberships, 'id'))

module.exports = MembershipsByOrgStore
