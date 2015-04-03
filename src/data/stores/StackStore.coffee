Stack                  = require 'data/models/Stack'
ModelStore             = require 'data/framework/ModelStore'
LoadStackRequest       = require 'data/requests/LoadStackRequest'
CreateTeamStackRequest = require 'data/requests/CreateTeamStackRequest'
CreateUserStackRequest = require 'data/requests/CreateUserStackRequest'
RenameStackRequest     = require 'data/requests/RenameStackRequest'
DeleteStackRequest     = require 'data/requests/DeleteStackRequest'

class StackStore extends ModelStore

  displayName: 'StackStore'
  name:        'stacks'
  modelType:   Stack

  listensFor: [
    'StacksLoaded'
    'StackChanged'
    'StackCreated'
    'StackDeleted'
    'UserCreatedStack'
    'UserCreatedTeamStack'
    'UserDeletedStack'
    'UserRenamedStack'
  ]

  load: (id) ->
    @execute new LoadStackRequest(id)

  onStacksLoaded: (event) ->
    @add(event.stacks)

  onStackChanged: (event) ->
    @add(event.stack)

  onStackCreated: (event) ->
    @add(event.stack)

  onStackDeleted: (event) ->
    @remove(event.stack.id)

  onUserCreatedStack: (event) ->
    @execute new CreateUserStackRequest(event.name)

  onUserCreatedTeamStack: (event) ->
    @execute new CreateTeamStackRequest(event.teamid, event.name)

  onUserDeletedStack: (event) ->
    @execute new DeleteStackRequest(event.stackid)

  onUserRenamedStack: (event) ->
    @execute new RenameStackRequest(event.stackid, event.name)

module.exports = StackStore
