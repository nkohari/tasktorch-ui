_                          = require 'lodash'
ListStore                  = require 'data/framework/ListStore'
LoadUsersByOrgRequest      = require 'data/requests/LoadUsersByOrgRequest'
AddLeaderToOrgRequest      = require 'data/requests/AddLeaderToOrgRequest'
RemoveLeaderFromOrgRequest = require 'data/requests/RemoveLeaderFromOrgRequest'
RemoveMemberFromOrgRequest = require 'data/requests/RemoveMemberFromOrgRequest'

class UsersByOrgStore extends ListStore

  displayName: 'UsersByOrgStore'
  name:        'usersByOrg'
  dependsOn:   'users'

  listensFor: [
    'UsersByOrgLoaded'
    'OrgChanged'
    'UserAddedLeaderToOrg'
    'UserRemovedLeaderFromOrg'
    'UserRemovedMemberFromOrg'
  ]

  load: (id) ->
    @execute new LoadUsersByOrgRequest(id)

  onUsersByOrgLoaded: (event) ->
    users = _.sortBy event.users, (user) -> user.name.toLowerCase()
    @set(event.orgid, _.pluck(users, 'id'))

  onOrgChanged: (event) ->
    @remove(event.org.id)

  onUserAddedLeaderToOrg: (event) ->
    @execute new AddLeaderToOrgRequest(event.orgid, event.userid)

  onUserRemovedLeaderFromOrg: (event) ->
    @execute new RemoveLeaderFromOrgRequest(event.orgid, event.userid)

  onUserRemovedMemberFromOrg: (event) ->
    @execute new RemoveMemberFromOrgRequest(event.orgid, event.userid)

module.exports = UsersByOrgStore
