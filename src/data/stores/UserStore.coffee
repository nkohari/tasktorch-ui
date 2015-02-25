User            = require 'data/models/User'
ModelStore      = require 'data/framework/ModelStore'
LoadUserRequest = require 'data/requests/LoadUserRequest'

class UserStore extends ModelStore

  displayName: 'UserStore'
  name:        'users'
  modelType:   User

  listensFor: [
    'UsersLoaded'
  ]

  load: (id) ->
    @execute new LoadUserRequest(id)

  onUsersLoaded: (event) ->
    @add(event.users)

module.exports = UserStore
