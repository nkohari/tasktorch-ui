_                         = require 'lodash'
ListStore                 = require 'data/framework/ListStore'
LoadSuggestedUsersRequest = require 'data/requests/LoadSuggestedUsersRequest'

class SuggestedUsersStore extends ListStore

  displayName: 'SuggestedUsersStore'
  name:        'suggestedUsers'
  dependsOn:   'users'

  listensFor: [
    'SuggestedUsersLoaded'
  ]

  load: (id) ->
    @execute new LoadSuggestedUsersRequest(id)

  onSuggestedUsersLoaded: (event) ->
    @set(event.phrase, _.pluck(event.users, 'id'))

module.exports = SuggestedUsersStore
