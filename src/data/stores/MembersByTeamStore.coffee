_                           = require 'lodash'
ListStore                   = require 'data/framework/ListStore'
LoadMembersByTeamRequest    = require 'data/requests/LoadMembersByTeamRequest'
AddLeaderToTeamRequest      = require 'data/requests/AddLeaderToTeamRequest'
AddMemberToTeamRequest      = require 'data/requests/AddMemberToTeamRequest'
RemoveLeaderFromTeamRequest = require 'data/requests/RemoveLeaderFromTeamRequest'
RemoveMemberFromTeamRequest = require 'data/requests/RemoveMemberFromTeamRequest'

class MembersByTeamStore extends ListStore

  displayName: 'MembersByTeamStore'
  name:        'membersByTeam'
  dependsOn:   'users'

  listensFor: [
    'MembersByTeamLoaded'
    'TeamChanged'
    'UserAddedLeaderToTeam'
    'UserAddedMemberToTeam'
    'UserRemovedLeaderFromTeam'
    'UserRemovedMemberFromTeam'
  ]

  load: (id) ->
    @execute new LoadMembersByTeamRequest(id)

  onMembersByTeamLoaded: (event) ->
    @set(event.teamid, _.map(event.users, 'id'))

  onTeamChanged: (event) ->
    @set(event.team.id, _.clone(event.team.members))

  onUserAddedLeaderToTeam: (event) ->
    @execute new AddLeaderToTeamRequest(event.teamid, event.userid)

  onUserAddedMemberToTeam: (event) ->
    @execute new AddMemberToTeamRequest(event.teamid, event.userid)

  onUserRemovedLeaderFromTeam: (event) ->
    @execute new RemoveLeaderFromTeamRequest(event.teamid, event.userid)

  onUserRemovedMemberFromTeam: (event) ->
    @execute new RemoveMemberFromTeamRequest(event.teamid, event.userid)

module.exports = MembersByTeamStore
