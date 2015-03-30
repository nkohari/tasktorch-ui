Team              = require 'data/models/Team'
ModelStore        = require 'data/framework/ModelStore'
CreateTeamRequest = require 'data/requests/CreateTeamRequest'
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
    'UserCreatedTeam'
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

  onUserCreatedTeam: (event) ->
    @execute new CreateTeamRequest(event.name)

  onUserRenamedTeam: (event) ->
    @execute new RenameTeamRequest(event.teamid, event.name)

module.exports = TeamStore
