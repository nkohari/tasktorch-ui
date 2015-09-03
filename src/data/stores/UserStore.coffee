UserFlag                = require 'data/enums/UserFlag'
User                    = require 'data/models/User'
ModelStore              = require 'data/framework/ModelStore'
LoadUserRequest         = require 'data/requests/LoadUserRequest'
ChangeMyNameRequest     = require 'data/requests/ChangeMyNameRequest'
ChangeMyEmailRequest    = require 'data/requests/ChangeMyEmailRequest'
ChangeMyPasswordRequest = require 'data/requests/ChangeMyPasswordRequest'
SetMyFlagRequest        = require 'data/requests/SetMyFlagRequest'

class UserStore extends ModelStore

  displayName: 'UserStore'
  name:        'users'
  modelType:   User

  listensFor: [
    'UsersLoaded'
    'UserChanged'
    'UserChangedName'
    'UserChangedEmail'
    'UserChangedPassword'
    'UserCompletedWalkthrough'
  ]

  load: (id) ->
    @execute new LoadUserRequest(id)

  onUsersLoaded: (event) ->
    @add(event.users)

  onUserChanged: (event) ->
    @add(event.user)

  onUserChangedName: (event) ->
    @execute new ChangeMyNameRequest(event.name)

  onUserChangedEmail: (event) ->
    @execute new ChangeMyEmailRequest(event.email)

  onUserChangedPassword: (event) ->
    @execute new ChangeMyPasswordRequest(event.password)

  onUserCompletedWalkthrough: (event) ->
    @execute new SetMyFlagRequest(UserFlag.HasCompletedWalkthrough, true)

module.exports = UserStore
