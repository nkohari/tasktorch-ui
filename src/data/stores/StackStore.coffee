Stack                  = require 'data/models/Stack'
ModelStore             = require 'data/framework/ModelStore'
LoadStackRequest       = require 'data/requests/LoadStackRequest'
CreateTeamStackRequest = require 'data/requests/CreateTeamStackRequest'
CreateUserStackRequest = require 'data/requests/CreateUserStackRequest'

class StackStore extends ModelStore

  displayName: 'StackStore'
  name:        'stacks'
  modelType:   Stack

  listensFor: [
    'StacksLoaded'
    'StackChanged'
    'StackCreated'
    'UserCreatedStack'
    'UserCreatedTeamStack'
  ]

  load: (id) ->
    @execute new LoadStackRequest(id)

  onStacksLoaded: (event) ->
    @add(event.stacks)

  onStackChanged: (event) ->
    @add(event.stack)

  onStackCreated: (event) ->
    @add(event.stack)

  onUserCreatedStack: (event) ->
    @execute new CreateUserStackRequest(event.name)

  onUserCreatedTeamStack: (event) ->
    @execute new CreateTeamStackRequest(event.teamid, event.name)

module.exports = StackStore
