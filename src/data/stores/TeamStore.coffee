Team              = require 'data/models/Team'
ModelStore        = require 'data/framework/ModelStore'
CreateTeamRequest = require 'data/requests/CreateTeamRequest'
DeleteTeamRequest = require 'data/requests/DeleteTeamRequest'
LoadTeamRequest   = require 'data/requests/LoadTeamRequest'
RenameTeamRequest = require 'data/requests/RenameTeamRequest'

class TeamStore extends ModelStore

  displayName: 'TeamStore'
  name:        'teams'
  modelType:   Team

  listensFor: [
    'TeamsLoaded'
    'TeamCreated'
    'TeamChanged'
    'TeamDeleted'
    'UserCreatedTeam'
    'UserDeletedTeam'
    'UserRenamedTeam'
  ]

  load: (id) ->
    @execute new LoadTeamRequest(id)

  onTeamsLoaded: (event) ->
    @add(event.teams)

  onTeamCreated: (event) ->
    @add(event.team)

  onTeamChanged: (event) ->
    @add(event.team)

  onTeamDeleted: (event) ->
    @remove(event.team.id)

  onUserCreatedTeam: (event) ->
    @execute new CreateTeamRequest(event.name, event.purpose, event.members, event.leaders)

  onUserDeletedTeam: (event) ->
    @execute new DeleteTeamRequest(event.teamid)

  onUserRenamedTeam: (event) ->
    @execute new RenameTeamRequest(event.teamid, event.name)

module.exports = TeamStore
