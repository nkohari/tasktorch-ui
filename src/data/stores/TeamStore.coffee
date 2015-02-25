Team            = require 'data/models/Team'
ModelStore      = require 'data/framework/ModelStore'
LoadTeamRequest = require 'data/requests/LoadTeamRequest'

class TeamStore extends ModelStore

  displayName: 'TeamStore'
  name:        'teams'
  modelType:   Team

  listensFor: [
    'TeamsLoaded'
  ]

  load: (id) ->
    @execute new LoadTeamRequest(id)

  onTeamsLoaded: (event) ->
    @add(event.teams)

module.exports = TeamStore
