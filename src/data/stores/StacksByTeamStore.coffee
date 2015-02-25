_                       = require 'lodash'
ListStore               = require 'data/framework/ListStore'
LoadStacksByTeamRequest = require 'data/requests/LoadStacksByTeamRequest'

class StacksByTeamStore extends ListStore

  displayName: 'StacksByTeamStore'
  name:        'stacksByTeam'
  dependsOn:   'stacks'

  listensFor: [
    'StacksByTeamLoaded'
  ]

  load: (id) ->
    @execute new LoadStacksByTeamRequest(id)

  onStacksByTeamLoaded: (event) ->
    @set(event.teamid, _.pluck(event.stacks, 'id'))

module.exports = StacksByTeamStore
