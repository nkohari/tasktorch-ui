_                          = require 'lodash'
Store                      = require 'framework/Store'
LoadUserRequest            = require 'requests/LoadUserRequest'
LoadFollowersByCardRequest = require 'requests/LoadFollowersByCardRequest'

class UserStore extends Store

  constructor: ->
    super()
    @currentUser = undefined

  getCurrentUser: ->
    @currentUser

  onUserDisplayed: (event) ->
    if @get(event.userId)?
      @announce()
    else
      @execute new LoadUserRequest(event.userId)

  onCardFollowersListDisplayed: (event) ->
    if @getMany(event.userIds)?
      @announce()
    else
      @execute new LoadFollowersByCardRequest(event.cardId)

  onUsersLoaded: (event) ->
    @add(event.users)

  onUserChanged: (event) ->
    @add(event.user)

  onCurrentUserLoaded: (event) ->
    if not @currentUser? or event.user.version > @currentUser.version
      @currentUser = event.user
      @announce()

module.exports = UserStore
