_                     = require 'lodash'
DocumentStatus        = require 'data/enums/DocumentStatus'
ListStore             = require 'data/framework/ListStore'
LoadTeamsByOrgRequest = require 'data/requests/LoadTeamsByOrgRequest'

class TeamsByOrgStore extends ListStore

  displayName: 'TeamsByOrgStore'
  name:        'teamsByOrg'
  dependsOn:   'teams'

  listensFor: [
    'TeamsByOrgLoaded'
    'TeamCreated'
    'TeamDeleted'
  ]

  load: (id) ->
    @execute new LoadTeamsByOrgRequest(id)

  onTeamsByOrgLoaded: (event) ->
    teams = _.sortBy event.teams, (team) -> team.name.toLowerCase()
    @set(event.orgid, _.pluck(teams, 'id'))

  onTeamCreated: (event) ->
    @remove(event.team.org)

  onTeamDeleted: (event) ->
    @remove(event.team.org)

module.exports = TeamsByOrgStore
