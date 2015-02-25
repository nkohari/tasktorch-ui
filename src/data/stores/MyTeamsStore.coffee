_                  = require 'lodash'
SingletonListStore = require 'data/framework/SingletonListStore'
LoadMyTeamsRequest = require 'data/requests/LoadMyTeamsRequest'

class MyTeamsStore extends SingletonListStore

  displayName: 'MyTeamsStore'
  name:        'myTeams'
  dependsOn:   'teams'

  listensFor: [
    'MyTeamsLoaded'
  ]

  load: ->
    @execute new LoadMyTeamsRequest()

  onMyTeamsLoaded: (event) ->
    @set(_.pluck(event.teams, 'id'))

module.exports = MyTeamsStore
