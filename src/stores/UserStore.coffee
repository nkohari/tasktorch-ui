_                          = require 'lodash'
Store                      = require 'framework/Store'
LoadUserRequest            = require 'requests/LoadUserRequest'
LoadFollowersByCardRequest = require 'requests/LoadFollowersByCardRequest'

class UserStore extends Store

  displayName: 'UserStore'

  constructor: ->
    super()
    @currentUser = undefined

  getCurrentUser: ->
    @currentUser

  onUserDisplayed: (event) ->
    if @get(event.userid)?
      @announce()
    else
      @execute new LoadUserRequest(event.userid)

  onCardFollowersListDisplayed: (event) ->
    if @getMany(event.userids)?
      @announce()
    else
      @execute new LoadFollowersByCardRequest(event.cardid)

  onUsersLoaded: (event) ->
    @add(event.users)

  onUserChanged: (event) ->
    @add(event.user)

  onCurrentUserLoaded: (event) ->
    if not @currentUser? or event.user.version > @currentUser.version
      @currentUser = event.user
      @announce()

module.exports = UserStore
