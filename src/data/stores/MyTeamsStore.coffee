_                  = require 'lodash'
SingletonListStore = require 'data/framework/SingletonListStore'
LoadMyTeamsRequest = require 'data/requests/LoadMyTeamsRequest'

class MyTeamsStore extends SingletonListStore

  displayName: 'MyTeamsStore'
  name:        'myTeams'
  dependsOn:   'teams'

  listensFor: [
    'MyTeamsLoaded'
    'TeamCreated'
    'TeamChanged'
    'TeamDeleted'
  ]

  load: ->
    @execute new LoadMyTeamsRequest()

  onMyTeamsLoaded: (event) ->
    @set(_.pluck(_.sortBy(event.teams, (t) -> t.name), 'id'))

  onTeamChanged: (event) ->
    @clear()

  onTeamCreated: (event) ->
    @clear()

  onTeamDeleted: (event) ->
    @clear()

module.exports = MyTeamsStore
