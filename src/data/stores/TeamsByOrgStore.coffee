_                     = require 'lodash'
ListStore             = require 'data/framework/ListStore'
LoadTeamsByOrgRequest = require 'data/requests/LoadTeamsByOrgRequest'

class TeamsByOrgStore extends ListStore

  displayName: 'TeamsByOrgStore'
  name:        'teamsByOrg'
  dependsOn:   'teams'

  listensFor: [
    'TeamsByOrgLoaded'
  ]

  load: (id) ->
    @execute new LoadTeamsByOrgRequest(id)

  onTeamsByOrgLoaded: (event) ->
    @set(event.orgid, _.pluck(event.teams, 'id'))

module.exports = TeamsByOrgStore
