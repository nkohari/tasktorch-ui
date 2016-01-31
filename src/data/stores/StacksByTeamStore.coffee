_                       = require 'lodash'
ListStore               = require 'data/framework/ListStore'
LoadStacksByTeamRequest = require 'data/requests/LoadStacksByTeamRequest'

class StacksByTeamStore extends ListStore

  displayName: 'StacksByTeamStore'
  name:        'stacksByTeam'
  dependsOn:   'stacks'

  listensFor: [
    'StacksByTeamLoaded'
    'StackCreated'
  ]

  load: (id) ->
    @execute new LoadStacksByTeamRequest(id)

  onStacksByTeamLoaded: (event) ->
    @set(event.teamid, _.map(event.stacks, 'id'))

  onStackCreated: (event) ->
    @remove(event.stack.team) if event.stack.team?

module.exports = StacksByTeamStore
