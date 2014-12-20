_     = require 'lodash'
Store = require 'framework/Store'

class UserStore extends Store

  constructor: ->
    super()
    @currentUser = undefined

  getCurrentUser: ->
    @currentUser

  onUsersLoaded: (event) ->
    @add(event.users)

  onCurrentUserLoaded: (event) ->
    if not @currentUser? or event.user.version > @currentUser.version
      @currentUser = event.user
      @announce()

module.exports = UserStore
