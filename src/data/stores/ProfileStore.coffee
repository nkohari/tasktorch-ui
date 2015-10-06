Profile                  = require 'data/models/Profile'
ModelStore               = require 'data/framework/ModelStore'
LoadProfileByUserRequest = require 'data/requests/LoadProfileByUserRequest'
ChangeMyBioRequest       = require 'data/requests/ChangeMyBioRequest'
ChangeMyTitleRequest     = require 'data/requests/ChangeMyTitleRequest'

class ProfileStore extends ModelStore

  displayName: 'ProfileStore'
  name:        'profiles'
  modelType:    Profile

  listensFor: [
    'ProfilesLoaded'
    'ProfileChanged'
    'UserChangedBio'
    'UserChangedTitle'
  ]

  key: (profile) ->
    profile.user

  load: (userid) ->
    @execute new LoadProfileByUserRequest(userid)

  onProfilesLoaded: (event) ->
    @add(event.profiles)

  onProfileChanged: (event) ->
    @add(event.profile)

  onUserChangedBio: (event) ->
    @execute new ChangeMyBioRequest(event.bio)

  onUserChangedTitle: (event) ->
    @execute new ChangeMyTitleRequest(event.title)

module.exports = ProfileStore
